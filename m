Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265902AbUGECcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265902AbUGECcX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 22:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265916AbUGECcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 22:32:23 -0400
Received: from dsl081-240-014.sfo1.dsl.speakeasy.net ([64.81.240.14]:12929
	"EHLO tumblerings.org") by vger.kernel.org with ESMTP
	id S265902AbUGECcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 22:32:17 -0400
Date: Sun, 4 Jul 2004 19:32:13 -0700
From: Zack Brown <zbrown@tumblerings.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems getting SMP to work with vanilla 2.4.26
Message-ID: <20040705023213.GA1557@tumblerings.org>
References: <20040704020543.GA1776@tumblerings.org> <20040704141336.GA18851@logos.cnet> <20040704181438.GB3816@tumblerings.org> <20040705002305.GA20847@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040705002305.GA20847@logos.cnet>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jul 04, 2004 at 09:23:05PM -0300, Marcelo Tosatti wrote:
> On Sun, Jul 04, 2004 at 11:14:38AM -0700, Zack Brown wrote:
> > Hi Marcelo, folks,
> > 
> > On Sun, Jul 04, 2004 at 11:13:36AM -0300, Marcelo Tosatti wrote:
> > > On Sat, Jul 03, 2004 at 07:05:43PM -0700, Zack Brown wrote:
> > > > Hi folks,
> > > > 
> > > > When booting vanilla 2.4.26 with SMP enabled, I get a lockup before the
> > > > boot sequence is completed. The same kernel with SMP disabled boots and runs
> > > > just fine. Both CPUs are detected by the system at bootup, before lilo takes
> > > > over. Here's the error as I wrote it down from the screen, followed by the
> > > > .config file:
> > > 
> > > I can't help much really. Tried CONFIG_ACPI_BOOT=n ? 
> > > 
> > I did a 'make dep' and 'make bzImage', and got the following error. It
> > looks like the kernel really wants that option enabled.
> 
> Hi Zack, 
> 
> Silly me, its not possible to compile SMP image without CONFIG_ACPI_BOOT (a lot of
> SMP detection code is linked to basic ACPI infrastructure).
> 
> Can you please try the nolapic/noapic boot options? They should disable the APIC, and
> if APIC is the "root" of your crashes, we will find out that way.
> 
> Sorry for the noise.

It turns out I tried 2.6.6 and got it working. Thanks for the help though!

I'm assuming the 2.4 thing is probably just a configuration problem at my
end, and not an actual kernel bug. If you think it might be a real bug,
I'm happy to keep trying other stuff to root it out.

Many thanks!
Zack

-- 
Zack Brown
