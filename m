Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293018AbSCEMQP>; Tue, 5 Mar 2002 07:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292996AbSCEMQF>; Tue, 5 Mar 2002 07:16:05 -0500
Received: from [199.203.178.211] ([199.203.178.211]:3717 "EHLO
	exchange.store-age.com") by vger.kernel.org with ESMTP
	id <S292986AbSCEMPx> convert rfc822-to-8bit; Tue, 5 Mar 2002 07:15:53 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
Subject: RE: FW: BUG in spinlock.h:133
MIME-Version: 1.0
Content-Type: text/plain;
	charset="x-user-defined"
Content-Transfer-Encoding: 8BIT
Date: Tue, 5 Mar 2002 14:15:13 +0200
Message-ID: <DCC3761A6EC31643A3BAF8BB584B26CC0AAE90@exchange.store-age.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FW: BUG in spinlock.h:133
Thread-Index: AcHDrHgEEZW54hkiQUCHwtkYEbYImgAkrejA
From: "Alexander Sandler" <ASandler@store-age.com>
To: "Robert Love" <rml@tech9.net>
Cc: "Linux Kernel \"Mailing List (E-mail)" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I found it. It was an uninitialized semahore. 
10x for help.

Alexandr Sandler.

> On Mon, 2002-03-04 at 06:50, Alexander Sandler wrote:
> 
> > I am getting a BUG in include/asm-i386/spinlock.h:133 when 
> I am doing some
> > I/O with driver I am working on. Does anyone has any idea 
> what it can be?
> > The system is Linux RedHat 7.1 on dual CPU machine running 
> kernel 2.4.16.
> 
> That BUG means lock->magic was not set properly, which is a debug-only
> parameter to make sure the lock was properly initialized.
> 
> Thus, either you are not properly initializing your 
> spin_locks or there
> is a memory corruption problem.
> 
> The EIP at the time of the BUG should of been reported - what was it? 
> Find it in your System.map to see where the problem is ...
> 
> 	Robert Love
