Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVFOXRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVFOXRD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 19:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVFOXRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 19:17:02 -0400
Received: from imf25aec.mail.bellsouth.net ([205.152.59.73]:44995 "EHLO
	imf25aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261654AbVFOXO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 19:14:58 -0400
Message-ID: <000101c57207$6b4f3de0$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: <linux-kernel@vger.kernel.org>
References: <000b01c57187$ade6b9b0$2800000a@pc365dualp2> <Pine.LNX.4.61L.0506151632280.13835@blysk.ds.pg.gda.pl>
Subject: Re: .../asm-i386/bitops.h  performance improvements
Date: Wed, 15 Jun 2005 19:48:29 -0400
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

The only thing I've seen so far that loses is a straight original 486.  Its
pipe is somewhat more simple minded and interlock prone than later models.
PPro, K6 and 386SX are big winners.

On the 386's, lacking actual pipeline, the compactness of the LEA over the
SHL/ADD can be more of an overriding factor.


----- Original Message ----- 
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: <cutaway@bellsouth.net>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, June 15, 2005 11:34
Subject: Re: .../asm-i386/bitops.h performance improvements


>
>  Be careful about model-specific penalties from using certain address
> modes and AGIs when using "lea" for such calculations.
>
>   Maciej

