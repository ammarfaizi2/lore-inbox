Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131997AbRCYOgR>; Sun, 25 Mar 2001 09:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132005AbRCYOgH>; Sun, 25 Mar 2001 09:36:07 -0500
Received: from [195.63.194.11] ([195.63.194.11]:41988 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S131997AbRCYOgC>; Sun, 25 Mar 2001 09:36:02 -0500
Message-ID: <3ABDFF3F.C7C64EB5@evision-ventures.com>
Date: Sun, 25 Mar 2001 16:22:55 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk, hpa@transmeta.com,
        torvalds@transmeta.com, tytso@MIT.EDU, linux-kernel@vger.kernel.org
Subject: Re: Larger dev_t
In-Reply-To: <UTC200103241425.PAA08694.aeb@vlet.cwi.nl> <3ABCB1D7.968452D6@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Also for 2.5, kdev_t needs to go away, along with all those arrays based
> on major number, and be replaced with either "struct char_device" or
> "struct block_device" depending on the device.
> 
> I actually went through the kernel in 2.4.0-test days and did this.
> Most kdev_t usages should really be changed to "struct block_device".
> The only annoyance in the conversion was ROOT_DEV and similar things
> that are tied into the boot process.  I didn't want to change that and
> potentially break the boot protocol...

Please se the patches I have send roughly a year to the list as well.
It's actually NOT easy. In esp the SCSI and IDE-CD usage of minor arrays
is
a huge obstacle.

-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort:
ru_RU.KOI8-R
