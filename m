Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264330AbUEINce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264330AbUEINce (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 09:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264332AbUEINce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 09:32:34 -0400
Received: from colin2.muc.de ([193.149.48.15]:53001 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264330AbUEINcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 09:32:32 -0400
Date: 9 May 2004 15:32:31 +0200
Date: Sun, 9 May 2004 15:32:31 +0200
From: Andi Kleen <ak@muc.de>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: "R. J. Wysocki" <rjwysocki@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       rusty@rustcorp.com.au, ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2
Message-ID: <20040509133231.GA25195@colin2.muc.de>
References: <fa.gcf87gs.1sjkoj6@ifi.uio.no> <fa.freqmjk.11j6bhe@ifi.uio.no> <409D3507.2030203@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409D3507.2030203@myrealbox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2004 at 12:29:11PM -0700, Andy Lutomirski wrote:
> R. J. Wysocki wrote:
> >On Saturday 08 of May 2004 13:31, Andrew Morton wrote:
> >
> >>"R. J. Wysocki" <rjwysocki@sisk.pl> wrote:
> >>
> >>>Sute, it's like that:
> >>>
> >>>kernel /boot/vmlinuz-2.6.6-rc3-mm2 root=/dev/sdb3 vga=792 hdc=ide-scsi
> >>>console=ttyS0,115200 console=tty0
> >>
> >>Please try `console=ttyS0'.
> >
> >
> >I have.  It does not help. :-(
> >
> >Still, reversing the Move-saved_command_line-to-init-mainc.patch _does_ 
> >help, even with the above command line.  I guess it's an x86_64-specific 
> >issue.
> 
> I had the same problem (serial console was broken on -mm on x86_64).  I 
> switched to i386, did 'make oldconfig', and rebuild, and it worked.  I 
> think this was 2.6.5-mm1.
> 
> Sorry I can't test it now -- I plan on sticking with 32 bit for a while 
> longer.

It is all the fault of Move-saved_command_line-to-init-mainc.patch
which unfortunately has been in -mm* for some time.

It simply breaks all boot arguments on x86-64.

Just get rid of that and the console is fine. Or use mainline.

-Andi
