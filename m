Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133045AbRDLOmf>; Thu, 12 Apr 2001 10:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133062AbRDLOmZ>; Thu, 12 Apr 2001 10:42:25 -0400
Received: from mail.axisinc.com ([193.13.178.2]:36614 "EHLO roma.axis.se")
	by vger.kernel.org with ESMTP id <S133045AbRDLOmO>;
	Thu, 12 Apr 2001 10:42:14 -0400
From: johan.adolfsson@axis.com
Message-ID: <070001c0c35f$201f3740$a8b270d5@homeip.net>
Reply-To: <johan.adolfsson@axis.com>
To: "Adam J. Richter" <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <200104121236.FAA03613@adam.yggdrasil.com>
Subject: Re: List of all-zero .data variables in linux-2.4.3 available
Date: Thu, 12 Apr 2001 16:44:48 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shouldn't a compiler be able to deal with this instead?
(Just a thought.)
/Johan

----- Original Message -----
From: Adam J. Richter <adam@yggdrasil.com>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, April 12, 2001 2:36 PM
Subject: List of all-zero .data variables in linux-2.4.3 available


> For anyone who is interested, I have produced a list of all
> of the .data variables that contain all zeroes and could be moved to
> .bss within the kernel and all of the modules (all of the modules
> that we build at Yggdrasil for x86, which is almost all).  These
> are global or static variables that have been declared
>
> int foo = 0;
>
> instead of
>
> int foo; /* = 0 */
>
> The result is that the .o files are bigger than they have
> to be.  The kernel memory image is not bigger, and gzip shrinks the
> runs of zeroes down to almost nothing, so it does not have a huge effect
> on bootable disks.  Still, it would be nice to save the disk space of
> the approximately 75 kilobytes of zeroes and perhaps squeeze in another
> sector or two when building boot floppies.
>
> I have also included a copy of the program that I wrote to
> find these all-zero .data variables.
>
> The program and the output are FTPable from
> ftp://ftp.yggdrasil.com/private/adam/linux/zerovars/.  Files with no
> all-zero .data variables are not included in the listing.  If you maintain
> any code in the kernel, you might want to look at the output to see
> how your code stacks up.
>
> Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite
104
> adam@yggdrasil.com     \ /                  San Jose, California
95129-1034
> +1 408 261-6630         | g g d r a s i l   United States of America
> fax +1 408 261-6631      "Free Software For The Rest Of Us."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

