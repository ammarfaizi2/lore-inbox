Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318000AbSGRDV2>; Wed, 17 Jul 2002 23:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318001AbSGRDV2>; Wed, 17 Jul 2002 23:21:28 -0400
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:23827 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S318000AbSGRDVP>;
	Wed, 17 Jul 2002 23:21:15 -0400
From: <Hell.Surfers@cwctv.net>
To: kelledin+LKML@skarpsey.dyndns.org, linux-kernel@vger.kernel.org
Date: Thu, 18 Jul 2002 04:23:50 +0100
Subject: RE:Re: File Corruption in Kernel 2.4.18
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1026962630897"
Message-ID: <057c03423031272DTVMAIL8@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1026962630897
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I disagree, its a bug in bash, i can justfeel it.

- I found it hard, it was hard to find, ohwell, whatever, nevermind. Kurt Cobain.

On 	Wed, 17 Jul 2002 22:11:13 -0500 	Kelledin <kelledin+LKML@skarpsey.dyndns.org> wrote:

--1026962630897
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Thu, 18 Jul 2002 04:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317988AbSGRDI2>; Wed, 17 Jul 2002 23:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317989AbSGRDI2>; Wed, 17 Jul 2002 23:08:28 -0400
Received: from 12-237-135-160.client.attbi.com ([12.237.135.160]:30468 "EHLO
	Midgard.attbi.com") by vger.kernel.org with ESMTP
	id <S317988AbSGRDI1> convert rfc822-to-8bit; Wed, 17 Jul 2002 23:08:27 -0400
Received: from valhalla (Valhalla.attbi.com [192.168.0.2])
	by Midgard.attbi.com (8.12.5/8.12.5) with ESMTP id g6I3BDSF021470;
	Wed, 17 Jul 2002 22:11:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: File Corruption in Kernel 2.4.18
Date: Wed, 17 Jul 2002 22:11:13 -0500
User-Agent: KMail/1.4.2
References: <3D362125.3A324489@atr.co.jp>
In-Reply-To: <3D362125.3A324489@atr.co.jp>
Cc: jhart@atr.co.jp
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207172211.13025.kelledin+LKML@skarpsey.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+hell.surfers=40cwctv.net@vger.kernel.org

This could possibly be a problem with your hard drive.  Judging 
from the model number, you have a 45GB IBM DeskStar 75GXP, one 
of the first IBM drives to earn the nickname "DeathStar" for its 
high failure rate.  What does IBM's Drive Fitness Test tell you?

I'll see about performing your test tonight; I've got a hefty 
little DivX directory I can throw around as I wait for 
j2sdk-1.4.0 to finish compiling.  Such a test should be 
sufficient...

This could also be a recurrence of ye olde VIA686B PCI+IDE issue.  
IIRC, some VIA686B motherboards that had that flaw were 
effectively unfixable, simply because certain motherboard 
manufacturers spotted the problem before everyone else (even 
VIA?) and tried their own partial kludge fixes for it.  Gotta 
love VIA.

On Wednesday 17 July 2002 09:00 pm, J. Hart wrote:
>      A large directory tree (70652 files, 7.6G) is copied
> recursively to an empty destination directory using the
> following commands :
>
>      mkdir aminet1/
>      cp -a aminet aminet1/
>
>      The source and destination directories are then compared
> using the following commands:
>
>      diff -r aminet aminet1/aminet > difflist
>
>      A few of the files at the copy destination, typically
> three or four, will usually be corrupt while the source files
> will be correct.  Occasionally the copy will be done without
> any corrupt files at the destination.  The mem=nopentium
> option appears to have no effect on this.  An overnight test
> using the memtest86 utility shows no memory errors.  The
> corruption in each file occurs in precise 4096 byte blocks. 
> An overnight test using the memtest86 utility shows no memory
> errors.  The corruption in each file occurs in precise 4096
> byte blocks.  System logs show no evidence of any trouble, and
> no kernel panics, warning messages or crashes are observed. 
> If there is any other user activity while the copy is running,
> the system will frequently lock up requiring a hard reset and
> reboot.  This forces a file system check due to the lack of a
> clean unmount.  System logs also show no evidence of any
> trouble after the lockup, and no kernel panics or other
> messages have been observed.
>
>      If a tar file is made of the source directory and then
> extracted, and the resultant extracted directory compared with
> the original, similar effects are observed.
>
>      Are there any kernel boot or build parameters which could
> be used to give additional diagnostics ?
>
> motherboard   : ASYS-A7V
> Linux version : Slackware 8
> Kernel        : 2.4.18
> hard disk     : ATA100 IBM-DTLA-307045 45gb
> hd controller : Promise Technology, Inc. 20265
> cpu           : 900mhz AMD Athlon

-- 
Kelledin
"If a server crashes in a server farm and no one pings it, does 
it still cost four figures to fix?"

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1026962630897--


