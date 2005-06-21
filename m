Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262395AbVFUWah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbVFUWah (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbVFUWaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:30:09 -0400
Received: from imf19aec.mail.bellsouth.net ([205.152.59.67]:28081 "EHLO
	imf19aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S262565AbVFUVlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:41:19 -0400
Message-ID: <008401c576b1$4f2ec000$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: "Jean Delvare" <khali@linux-fr.org>, "Denis Vlasenko" <vda@ilport.com.ua>
Cc: "LKML" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.62.0506200052320.2415@dragon.hyggekrogen.localhost><200506211359.25632.vda@ilport.com.ua> <20050621232409.06a3400e.khali@linux-fr.org>
Subject: Re: [RFC] cleanup patches for strings
Date: Tue, 21 Jun 2005 18:33:39 -0400
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

Jean, the default string alignments GCC seems to insist on using are going
to screw you far more than the extra byte here or there ;->

I've measured close to 100K+ of fluff 0x00 pad bytes in a 2.6 kernel that
are due to GCC.  FWIW, a while ago I posted a small utility to measure this
grotesque wastage.

----- Original Message ----- 
From: "Jean Delvare" <khali@linux-fr.org>
To: "Denis Vlasenko" <vda@ilport.com.ua>
Cc: "LKML" <linux-kernel@vger.kernel.org>
Sent: Tuesday, June 21, 2005 17:24
Subject: Re: [RFC] cleanup patches for strings


>
> I think so. I can't think of a more useless way to waste memory ;)

