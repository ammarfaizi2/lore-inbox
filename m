Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264278AbUGNU5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUGNU5c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 16:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264579AbUGNU5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 16:57:32 -0400
Received: from fmr06.intel.com ([134.134.136.7]:63194 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264278AbUGNU5b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 16:57:31 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Real-Time thread scheduling in linux??
Date: Wed, 14 Jul 2004 13:56:50 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A6EBF56@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Real-Time thread scheduling in linux??
Thread-Index: AcRppnveZXXDRuolTlG2ahg9aRqKnwAPVEnQ
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Harish K Harshan" <harish@amritapuri.amrita.edu>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Jul 2004 20:56:51.0399 (UTC) FILETIME=[16318D70:01C469E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Harish K Harshan
>
>      I would like to know if there is any way to give a thread real-time
> priority under Linux, and also if it is possible using the pthread
> library. How would the kernel handle such threads? And do we need to
> implement locking systems, so that this thread does not block other
> threads permanently? Please help me, because I am working on a data
> acquisition application, and the acquisition thread needs almost
> real-time priority, and loss of data is not affordable.

This is a user space POSIX API issue. You need to use pthread_setscheduler(),
on a recent glibc. The kernel doesn't handle threads or processes 
differently, so the whole process will not block if one of the
threads does.

[this is all assuming you are using a glibc with NPTL as threading
library, as most Linux distros should have now].

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
