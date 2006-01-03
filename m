Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWACPkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWACPkc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 10:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWACPkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 10:40:32 -0500
Received: from general.keba.co.at ([193.154.24.243]:64147 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S1751440AbWACPkb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 10:40:31 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
Date: Tue, 3 Jan 2006 16:40:28 +0100
Message-ID: <AAD6DA242BC63C488511C611BD51F367323315@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
Thread-Index: AcYQdqJYlvJlg2CoTbGUyf1yPSATIwAA5gNQ
From: "kus Kusche Klaus" <kus@keba.com>
To: "Daniel Walker" <dwalker@mvista.com>, "kus Kusche Klaus" <kus@keba.com>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Lee Revell" <rlrevell@joe-job.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Daniel Walker
> Most likely . It's hard to create a global solution in the entry-*.S
> files cause the code in there is called so early.  

One more problem: 
There seem to be more irq enable/disable than in entry-header.S:
entry-armv.S contains an open-coded enable, 
asm-arm/assembler.h defines irq save/restore macros, ...

And they all do not trace.

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
