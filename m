Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132437AbRAaRF4>; Wed, 31 Jan 2001 12:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132430AbRAaRFs>; Wed, 31 Jan 2001 12:05:48 -0500
Received: from winds.org ([207.48.83.9]:6667 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S131409AbRAaRFl>;
	Wed, 31 Jan 2001 12:05:41 -0500
Date: Wed, 31 Jan 2001 12:04:41 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: VIA VT82C686X
In-Reply-To: <Pine.LNX.4.21.0101302105170.4439-100000@ns-01.hislinuxbox.com>
Message-ID: <Pine.LNX.4.21.0101311148560.20840-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001, David D.W. Downey wrote:

> I removed the ide and ata setting. System is running stably as in no
> kernel crashes, but I am getting daemon and shell crashes. With this
> current kernel I've had 1 kernel crash in about 3 hours as compared to 1
> every 10 or 15 minutes. Crash, reboot, 10 minutes or so crash, reboot. ect
> ect.
> 
> I'm wanting to test something else out. I'm wondering if there isn't some
> hardware issue with the RAM. This particular board will do 1GB of PC133,
> or 2.5GB of PC100. I'm wondering if there isn't something wrong with how
> it reads the speed and the appropriate limitation. It's running stably if
> I only run 768MB of PC133 RAM. But if I run a solid 1GB of PC133 I get
> segfaults and sig11 crashes constantly. All the RAM has been
> professionally tested and certified.

That definitely sounds like a RAM problem. The system should perform the same
independent of how many RAM chips you put in there (segfault-wise). If you're
still in doubt, you can try booting up with memtest86 and run it for several
hours with only the memory chip that you think might be causing the problem.

You can grab the bootdisk image from:
  ftp://ftp.winds.org/linux/images/memtest86-2.5.bin

and just write it to a floppy with 'cat memtest86-2.5.bin > /dev/fd0', then
boot up with that disk.

Regards,
 Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: bstanoszek@comtime.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
