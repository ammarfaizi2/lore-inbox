Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbTDCUHn 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 15:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263592AbTDCUHm 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 15:07:42 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:15877 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S263591AbTDCUHf convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 15:07:35 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] reduce stack in cpqarray.c::ida_ioctl()
Date: Thu, 3 Apr 2003 14:18:57 -0600
Message-ID: <45B36A38D959B44CB032DA427A6E10640451339C@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] reduce stack in cpqarray.c::ida_ioctl()
Thread-Index: AcL6HAzh3Rm9zb09TEG/+WXteHTpigAAWHXg
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>, "lkml" <linux-kernel@vger.kernel.org>
Cc: "Arrays" <arrays@hp.com>
X-OriginalArrivalTime: 03 Apr 2003 20:18:58.0226 (UTC) FILETIME=[41F3E120:01C2FA1E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This patch to 2.5.66 reduces stack usage in ida_ioctl() by about
> 0x500 bytes (on x86).

Looks ok to me, (but i haven't tried it.)

>
> There is a possibility that the allocation here should be done one time
> only and the buffer pointer saved for re-use instead of allocating it
> on each call to ida_ioctl.  If that's desirable, I'll have a few
> questions.

No, I don't think so.  I think we should
allow for the possibllity of concurrent calls 
to this ioctl.  (whether linux allows it is 
another question.  I think it used to be the case
that only one ioctl could get in at a time... I can't
recall if it's still that way.)

-- steve

