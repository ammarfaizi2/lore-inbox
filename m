Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUCJMWk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 07:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbUCJMWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 07:22:39 -0500
Received: from moutng.kundenserver.de ([212.227.126.184]:41982 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262580AbUCJMUl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 07:20:41 -0500
From: "Ingo at Pyrillion" <ingo@pyrillion.org>
To: "'Nakajima, Jun'" <jun.nakajima@intel.com>,
       "'Norihiko Mukouyama'" <norihiko_m@jp.fujitsu.com>,
       "'Stefan Smietanowski'" <stesmi@stesmi.com>,
       "'Norberto Bensa'" <norberto+linux-kernel@bensa.ath.cx>
Cc: <linux-kernel@vger.kernel.org>
Subject: AW: Kernel 2.6.3 patch for Intel Compiler 8.0
Date: Wed, 10 Mar 2004 13:20:32 +0100
Message-ID: <000301c4069a$15fd7980$374ca8c0@bunnybook2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <7F740D512C7C1046AB53446D37200173FEB4C2@scsmsx402.sc.intel.com>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:c4c36d513a3e07b982252e2b8ea3678d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jun,

the patch I submitted is for icc 8.0, i.e. I386 platform only.

Did I understand your last message right that you even do not
need a kernel patch for icc, i.e. I386?

If so, then try to compile the 2.6.3 kernel using icc without
applying my patch and see what happens if icc "tries" to compile
hybrid code, i.e. mixed assembly and C statements....
The current icc 8.0 (and also icc 7.0) makes FATAL mistakes
compiling those mixings. Just check the object file that results
from "dec_and_lock.c" in arch/i386/lib using a disassembler.

Rgs, Ingo.

-----Ursprüngliche Nachricht-----
Von: Nakajima, Jun [mailto:jun.nakajima@intel.com] 
Gesendet: Mittwoch, 10. März 2004 03:53
An: Norihiko Mukouyama; Stefan Smietanowski; Norberto Bensa
Cc: Ingo at Pyrillion; linux-kernel@vger.kernel.org
Betreff: RE: Kernel 2.6.3 patch for Intel Compiler 8.0


In 2.6, we already have sufficient changes for Intel IPF Compiler to
build the kernel, especially intrinscs changes, and you should not need
a patch. To make it faster, we might want to use PGO (profile guided
optimization) provided by the compiler; yes, it's available even for the
kernel with a driver.

Thanks,
Jun

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel- 
>owner@vger.kernel.org] On Behalf Of Norihiko Mukouyama
>Sent: Tuesday, March 09, 2004 6:08 PM
>To: Stefan Smietanowski; Norberto Bensa
>Cc: Ingo at Pyrillion; linux-kernel@vger.kernel.org
>Subject: RE: Kernel 2.6.3 patch for Intel Compiler 8.0
>
>Hi,Stefan!!
>
>>1/3 of the things are faster with icc. 2/3 of the things are faster 
>>with gcc. Performance numbers not given.
>
>Thank you very much.
>I understood that meaning.
>
>By the way,
>
>I would like to learn the result of making his patch run on Itanium2. 
>Because, the difference of the performance of the compiler being sure
to
>influence most
>remarkably.
>
>Can  anyone try?
>
>Thanks.
>
>Norihiko
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

