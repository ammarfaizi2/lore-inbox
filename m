Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbUKKSNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbUKKSNK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 13:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbUKKSLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 13:11:07 -0500
Received: from msgbas2x.cos.agilent.com ([192.25.240.37]:36035 "EHLO
	msgbas2x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S262301AbUKKSJN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 13:09:13 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: module tool with 2.6.9 limitation issue
Date: Thu, 11 Nov 2004 11:09:04 -0700
Message-ID: <08A354A3A9CCA24F9EE9BE13600CFBC50F3AED@wcosmb07.cos.agilent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: QM_MODULES not implemented in 2.6.9
Thread-Index: AcTCoUUa1X9I9dtzTa2jC8HE2IsmowFdVWIg
From: <yiding_wang@agilent.com>
To: <arjan@infradead.org>, <rddunlap@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <yiding_wang@agilent.com>
X-OriginalArrivalTime: 11 Nov 2004 18:09:05.0237 (UTC) FILETIME=[87DD2050:01C4C819]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using moudle-init-tools-3.1-pre6 with kernel 2.6.9. The new insmod seems have restrictions which failed using parameters to load a driver module.

My module parameter is in the form of modname="*************** ****", a quite long one.
Run - insmod modname.o modname="*********** *******" (with a script), it complains about the space and treats the string next to the space to be a "Unknown parameter".

By replacing the space with any character, then it complains 
"modname: string parameter too long"

Reducing the length of the parameter to less than 1k character works fine.

Same long parameter string wit space in between works fine under 2.4.25 with original insmod.

Questions:
1, Is this a bug or new insmod has restrictions? 
2, If it is restriction on special character such as space, or limitation on parameter length, then why and what is the limit? 
3, If insmod has limitation, then what is better way to pass long parameter with some special character? 

Thanks!

Eddie
