Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293590AbSBZMJc>; Tue, 26 Feb 2002 07:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293591AbSBZMJW>; Tue, 26 Feb 2002 07:09:22 -0500
Received: from mtao4.east.cox.net ([68.1.17.241]:24310 "EHLO
	lakemtao04.cox.net") by vger.kernel.org with ESMTP
	id <S293590AbSBZMJH>; Tue, 26 Feb 2002 07:09:07 -0500
Message-ID: <009c01c1bebe$41321730$a7eb0544@CX535256D>
From: "Barubary" <barubary@cox.net>
To: "Rainer Ellinger" <rainer@ellinger.de>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <006001c1beb9$ea412690$a7eb0544@CX535256D> <3C7B7908.1040508@ellinger.de>
Subject: Re: ISO9660 bug and loopback driver bug
Date: Tue, 26 Feb 2002 04:08:08 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you try a file between 2^31 and 2^32-1, inclusive?  Maybe it's a
sign-related bug in the loopback driver, not a 64 bit I/O bug.

The file I tried to mount is this on an NTFS partition:

12/10/2001  20:13     3,522,562,048 dvd.iso

"losetup" fails too, meaning it's the loopback driver (and possibly the NTFS
driver) that is glitching, not the ISO driver.

Maybe trying to mount *anything* from an NTFS driver doesn't work?  I'll
have to check that possibility too...

-- Barubary

----- Original Message -----
From: "Rainer Ellinger" <rainer@ellinger.de>
To: "Barubary" <barubary@cox.net>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, February 26, 2002 4:01 AM
Subject: Re: ISO9660 bug and loopback driver bug


> Barubary wrote:
>
> > Now the loopback bug.  Files whose size is greater than 2^31-1 don't
work
> > with the loopback driver.
>
> Can't reproduce. I can mount 4.7GB DVD-Images and i'm currently working
with an 48GB File mounted via loop, and a 100GB partition
> mounted via loop. I'm using loop-AES encryption patch with 2.4.17/18-rc4.
I'm not aware if there's a fix in this patch. afaik it
> should also work with vanilla loop.c.
>
> --
> rainer@ellinger.de
>
>

