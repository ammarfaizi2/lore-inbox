Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbVLOTAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbVLOTAt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 14:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbVLOTAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 14:00:49 -0500
Received: from smarthost2.sentex.ca ([205.211.164.50]:24278 "EHLO
	smarthost2.sentex.ca") by vger.kernel.org with ESMTP
	id S1750929AbVLOTAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 14:00:48 -0500
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, "'Meelis Roos'" <mroos@linux.ee>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Serial: bug in 8250.c when handling PCI or other level triggers
Date: Thu, 15 Dec 2005 14:00:31 -0500
Organization: Connect Tech Inc.
Message-ID: <000901c601a9$d243fe50$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <1134599362.25663.72.camel@localhost.localdomain>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: On Behalf Of Alan Cox
> I don't think so. The bug as such is something I can only see being
> triggerable either by a virtual machine or by something like serious
> noise on the signal lines (eg put a 10Khz carrier on the 
> carrier detect
> line)

We found and patched this bug in one of our products. The patch was to
raise the loop counter to something more appropriate for our hardware.
The condition: the not-to-speedy embedded CPU and all ports in use.
The interrupt handler would hit the loop limit because the combination
of all ports running meant usually there was one port that needed
servicing, upping the loop count by one.

..Stu

