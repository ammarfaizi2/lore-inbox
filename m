Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269392AbUIIJ65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269392AbUIIJ65 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 05:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269398AbUIIJ65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 05:58:57 -0400
Received: from mf2.realtek.com.tw ([220.128.56.22]:36105 "EHLO
	mf2.realtek.com.tw") by vger.kernel.org with ESMTP id S269392AbUIIJ6y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 05:58:54 -0400
Message-ID: <00cf01c49653$9ad48f10$8b1a13ac@realtek.com.tw>
From: "colin" <colin@realtek.com.tw>
To: "Paulo Marques" <pmarques@grupopie.com>
Cc: <linux-kernel@vger.kernel.org>
References: <009901c4964a$be2468e0$8b1a13ac@realtek.com.tw> <4140200B.9060408@grupopie.com>
Subject: =?iso-8859-1?Q?Re:_=A1@=5B*=A9U=A7=A3=B6l=A5=F3*=5D_Re:_What_File_Syste?=
	=?iso-8859-1?Q?m_supports_Application_XIP?=
Date: Thu, 9 Sep 2004 17:58:44 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at
 2004/09/09 =?Big5?B?pFWkyCAwNTo1OTo0OA==?=,
	Serialize by Router on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at 2004/09/09
 =?Big5?B?pFWkyCAwNTo1OTo0OQ==?=,
	Serialize complete at 2004/09/09 =?Big5?B?pFWkyCAwNTo1OTo0OQ==?=
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Paulo,
Cramfs seems to support it now.
At the beginning, I also think it's impossible to support Application XIP in
Cramfs.
http://www.denx.de/twiki/publish/DULG/ConfigureLinuxForXIP.html

Regards,
Colin


----- Original Message ----- 
From: "Paulo Marques" <pmarques@grupopie.com>
To: "colin" <colin@realtek.com.tw>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, September 09, 2004 5:19 PM
Subject: ¡@[*©U§£¶l¥ó*] Re: What File System supports Application XIP


> colin wrote:
> >
> > Hi there,
> > We are developing embedded Linux system. Performance is our
consideration.
> > We hope some applications can run as fast as possible,
> > and are think if they can be put in a filesystem image, which resides in
> > RAM, and run in XIP (eXecute In Place)  manners.
> > I know that Cramfs has supported Application XIP. Is there any other FS
that
> > also supports it? Ramdisk? Ramfs? Romfs?
>
> Obvisously cramfs can not support XIP, because the "in-place" image
> is compressed (unless you have a processor that can execute compressed
> code :)
>
> AFAIK only tmpfs supports XIP because it works on a higher level
> without using block devices underneath. Ramdisks are simply RAM
> block devices that behave like any other block device.
>
> You can have a compressed image in flash (for instance), decompress
> everything into a tmpfs and execute from there.
>
> I'm not sure, however, that this will be such a performance gain.
>
> If you use cramfs (for instance) then the kernel will uncompress
> and run only the pages that are needed, and they will be cached in
> page cache so that they will be available again when needed. This
> way you only waste the RAM you actually need, and can still drop
> old pages if the application needs more RAM.
>
> Just my two cents,
>
> -- 
> Paulo Marques - www.grupopie.com
>
> To err is human, but to really foul things up requires a computer.
> Farmers' Almanac, 1978
>


