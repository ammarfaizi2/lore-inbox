Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWAWWBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWAWWBw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 17:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWAWWBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 17:01:52 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:62134
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S964911AbWAWWBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 17:01:51 -0500
Date: Mon, 23 Jan 2006 14:01:45 -0800
From: Greg KH <gregkh@suse.de>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: david-b@pacbell.net, ak@suse.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: EHCI + APIC errors = no usb goodness
Message-ID: <20060123220145.GA27944@suse.de>
References: <20060123210443.GA20944@suse.de> <20060123132554.13411a1d.zaitcev@redhat.com> <20060123214115.GA15338@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060123214115.GA15338@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 01:41:15PM -0800, Greg KH wrote:
> On Mon, Jan 23, 2006 at 01:25:54PM -0800, Pete Zaitcev wrote:
> > On Mon, 23 Jan 2006 13:04:43 -0800, Greg KH <gregkh@suse.de> wrote:
> > 
> > > Now I'm down to the last problem, USB doesn't work, which is a bit of a
> > > pain for me :)
> > 
> > > [   87.406180] APIC error on CPU0: 00(40)
> > > [   87.426282] drivers/usb/core/inode.c: creating file '001'
> > > [   87.426333] hub 1-0:1.0: state 5 ports 8 chg 0000 evt 0000
> > > [   87.712002] APIC error on CPU0: 40(40)
> > > [   87.774743] irq 16: nobody cared (try booting with the "irqpoll" option)
> > 
> > Why do you even enable APIC on an old laptop? We tried it a few times,
> > it's just not possible. I'd say, about one in ten to one in five of 2002
> > vintage laptops will not even boot, let alone work when APIC is enabled.
> > Some of them are well known, like Dell Lattitude 610. I expect this to
> > change with dual-core laptops, but for now the rule is: UP kernel,
> > No APIC, for distro kernels at least.
> 
> Hm, it's a brand-new laptop, and all of my other boxes work with ioapic
> on UP kernels.  I didn't think to turn it off, I'll go rebuild and see
> if that helps.

Nope, didn't help, no more APIC errors though, but the usb interrupt is
still disabled.

I'll go have fun with 'git bisect' and see what happens...

thanks,

greg k-h
