Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317493AbSHHJ0R>; Thu, 8 Aug 2002 05:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317500AbSHHJ0R>; Thu, 8 Aug 2002 05:26:17 -0400
Received: from [195.63.194.11] ([195.63.194.11]:23307 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317493AbSHHJ0Q>; Thu, 8 Aug 2002 05:26:16 -0400
Message-ID: <3D5238BA.7070307@evision.ag>
Date: Thu, 08 Aug 2002 11:24:10 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: mingo@elte.hu, alan@lxorguk.ukuu.org.uk, Andries.Brouwer@cwi.nl,
       johninsd@san.rr.com, linux-kernel@vger.kernel.org
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
References: <200208080908.CAA10230@adam.yggdrasil.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Adam J. Richter napisa³:

> 
> | The head/sector mismatch check (fn 8h/fn 48h) has actually been in LILO
> | since last year (22.0), and the (kernel/bios) check since 22.2.  It has
> | only been seriously visible since the introduction of the 2.4.18 kernel.
> | The IDE disk drivers are now reporting actual IDE disk geometry, rather
> | than the mapped BIOS geometry, which was reported by all previous kernels.
> | This change in the results returned by the IOCTL used to get the disk
> | geometry has been extremely annoying.  It also leads to complaints about
> | the format of the partition table.
> 
> 	Earlier in that seem email, he indicated that he was
> thinking about giving precedence to the BIOS geometry in future
> versions of lilo (this was 22.3, and I believe the current version is
> now 22.3.1):

How did he think DOS does disk access during dos fdisk time before?
As far as I can see lilo is relying on the BIOS during the "dot printing 
phase" anyway so this should have been this way since day one of lilo.
*Not* the other way around.

> | Actually, on serious reflection on the issue, there is no choice:  the
> | value returned by (int 13h/fn 8h) should be used, if it is available.  This
> | is the value used by the conversion routine (linear/lba32 -> geometric) in
> | the boot loader (read.S).  Currently, the kernel value is given precedence;
> | I am seriously reviewing this issue.
> 
> 	I just wonder if this is the problem that you are experiencing
> rather than anything that was new in 2.5.29.

Yes.

