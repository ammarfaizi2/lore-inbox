Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUETNT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUETNT0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 09:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265050AbUETNT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 09:19:26 -0400
Received: from [202.125.86.130] ([202.125.86.130]:18923 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S265127AbUETNTZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 09:19:25 -0400
Subject: protecting source code in 2.6
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Date: Thu, 20 May 2004 18:48:09 +0530
Content-class: urn:content-classes:message
Message-ID: <1118873EE1755348B4812EA29C55A97222FD0D@esnmail.esntechnologies.co.in>
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: protecting source code in 2.6
Thread-Index: AcQ+bOUisDDizou9Q82Xv3rWdOFD2A==
From: "Jinu M." <jinum@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Cc: <kernelnewbies@nl.linux.org>,
       "Surendra I." <surendrai@esntechnologies.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

We are developing a block device driver on linux-2.6.x kernel. We want
to distribute our driver as sum of source code and librabry/object code.

We have divided the source code into two parts. The os interface module 
and the device interface module. The os interface module (osint.c) has 
all the os interface functions (init, exit, open, close, ioctl, request
queue handling etc). The device interface module (devint.c) on the other
hand has all the device interface functions (initialize device, read, 
write etc), these don't use system calls or kernel APIs.

The device interface module is proprietary source and we don't intend
to distribute it with source code on GPL license.

What we intend to do is, distribute the os interface module (osint.c)
with
source code and the device interface module as object code or library.
The
user will compile the os interface module on the target box and link it 
with the device interface module to generate the .ko (loadable module).

We are not very sure of how to achieve this. 
Please help us address this issue.

Thanks in advance,
-Jinu 
