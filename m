Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbTJNVSH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 17:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbTJNVSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 17:18:06 -0400
Received: from fmr06.intel.com ([134.134.136.7]:30941 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262467AbTJNVSD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 17:18:03 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Question on atomic_inc/dec
Date: Tue, 14 Oct 2003 14:17:49 -0700
Message-ID: <A20D5638D741DD4DBAAB80A95012C0AED78649@orsmsx409.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question on atomic_inc/dec
Thread-Index: AcOShHL4yEdcow77Q6OIihFkyw+3ggAE/WJQ
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "sankar" <san_madhav@hotmail.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Oct 2003 21:17:49.0791 (UTC) FILETIME=[9F116EF0:01C39298]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: sankar
> 
> Hi,
> I have a question concerning the macro atomic_inc on REDHAT 9.0. I had used
> atomic_inc on REDHAT 7.2 earlier. I installed redhat 9.0 and tried to run my
> old code on this. I got the error saying atomic_inc not declared.
> 
> I tried to search the header file in which this is defined but with failure.

Seems you were using a kernel definition of a function (this 
normally happens only because it was out there by mistake,
or because you had __KERNEL__ #defined).

It will be in include/asm/atomic.h; however, it is not wise to
use directly the kernel stuff unless you are coding kernel stuff.

You can always strip them, of course :)

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
