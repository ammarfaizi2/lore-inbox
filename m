Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131680AbRCXOl0>; Sat, 24 Mar 2001 09:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131681AbRCXOlR>; Sat, 24 Mar 2001 09:41:17 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:1497 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S131680AbRCXOlF>;
	Sat, 24 Mar 2001 09:41:05 -0500
Message-ID: <3ABCB1D7.968452D6@mandrakesoft.com>
Date: Sat, 24 Mar 2001 09:40:23 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
Cc: alan@lxorguk.ukuu.org.uk, hpa@transmeta.com, torvalds@transmeta.com,
        tytso@MIT.EDU, linux-kernel@vger.kernel.org
Subject: Re: Larger dev_t
In-Reply-To: <UTC200103241425.PAA08694.aeb@vlet.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also for 2.5, kdev_t needs to go away, along with all those arrays based
on major number, and be replaced with either "struct char_device" or
"struct block_device" depending on the device.

I actually went through the kernel in 2.4.0-test days and did this. 
Most kdev_t usages should really be changed to "struct block_device". 
The only annoyance in the conversion was ROOT_DEV and similar things
that are tied into the boot process.  I didn't want to change that and
potentially break the boot protocol...

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
