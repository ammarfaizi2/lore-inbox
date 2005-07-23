Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVGWGah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVGWGah (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 02:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVGWGah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 02:30:37 -0400
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:45720 "EHLO
	imf22aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261283AbVGWGaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 02:30:35 -0400
Message-ID: <01bd01c58f50$0998c650$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: <linux-kernel@vger.kernel.org>
References: <42E14134.1040804@yahoo.co.uk> <20050722201416.GM3160@stusta.de>
Subject: Re: kernel optimization
Date: Sat, 23 Jul 2005 02:30:31 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Adrian Bunk" <bunk@stusta.de>
To: "christos gentsis" <christos_gentsis@yahoo.co.uk>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, July 22, 2005 16:14
Subject: Re: kernel optimization
>
> It's completely untested.
> And since it's larger, it's also slower.

Larger does not always mean slower.  If it did, nobody would implement a
loop unrolling optimization.

ex. Look at how GCC generates jump tables for switch() when there's about
10-12 (or more) case's sparsely scattered in the rage from 0 through 255.
It generates a 256 element directly indexed jump table (obviously with many
duplicate entries).  This is faster than a cascaded if/else
construct(particularly for those that would have been on the end of the
if/else chain), but it is a very large construct.  You'll see some of these
"plump" switches generated in various SCSI drivers and in the VT102
emulation if you disassemble them.


