Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965020AbVHOWeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbVHOWeK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbVHOWeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:34:10 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:64668 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965020AbVHOWeI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:34:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UF+Cg867TqzTSsNU0rdjF5jywKORGttLMpYLWVNYD7KAdAcfQ4Xf3b1hdFL1FVcxV+QnsUxGtfHsyH+bphuUuu/X4/m0Iq/Ye2YzrCa4GohDO6b1qhnxHQA72NnvGDqMsQgtRJLyJ3uH+7TADVnyKeKT7ZU12ywTVvGHrDRc3m0=
Message-ID: <7f45d939050815153448a44e0f@mail.gmail.com>
Date: Mon, 15 Aug 2005 15:34:04 -0700
From: Shaun Jackman <sjackman@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Trouble shooting a ten minute boot delay (SiI3112)
Cc: lkml <linux-kernel@vger.kernel.org>, Tejun Heo <htejun@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
In-Reply-To: <1123901740.5296.100.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7f45d939050809163136a234a@mail.gmail.com>
	 <42FC0DD4.9060905@gmail.com>
	 <7f45d93905081201001a51d51b@mail.gmail.com>
	 <42FC57EC.2060204@pobox.com>
	 <7f45d93905081210441e209e31@mail.gmail.com>
	 <Pine.LNX.4.61.0508122039390.16845@yvahk01.tjqt.qr>
	 <7f45d93905081212087ea5910a@mail.gmail.com>
	 <Pine.LNX.4.61.0508122113510.16845@yvahk01.tjqt.qr>
	 <7f45d939050812183911812222@mail.gmail.com>
	 <1123901740.5296.100.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/8/12, Steven Rostedt <rostedt@goodmis.org>:
> Is the keyboard ever set up then? This is all happening before
> console_init (since that's when the prints start) and the early printk
> won't show anything before it parses the options.  For other
> architectures, I use to write out to the serial really early, just an
> 'x'. If you know how to do that, you could give it a try. Start at
> start_kernel in main hopefully you see the 'x'. If you do, keep moving
> it until you find where it's delaying.  Of course, this could be before
> start_kernel, then you're really screwed, unless you're good at doing
> the same in assembly (which I've done for MIPS, PPC and ARM, but never
> for x86).

Since each reboot takes ten minutes, this would be a tedious process.
Thanks for the suggestion though.

> > I compiled a vanilla 2.6.12.4 kernel, enabled EARLY_PRINTK and
> > rebooted with earlyprintk=vga. The kernel didn't display any extra
> > information before the delay.
> 
> Do you see grub saying "uncompressing kernel..." or whatever that says?

Grub says...

root (hd2,2)
  Filesystem type is ext2fs, partition type 0x83
kernel /boot/vmlinuz-2.6.12.4 root=/dev/md0 ro nodma
   [Linux-bzImage, setup=0x1e00, size=0x1302ff]

I suspect this second message is where grub decompresses the kernel.
The last message grub displays is simply...

boot

Cheers,
Shaun
