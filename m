Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTJNVjY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 17:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbTJNVjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 17:39:24 -0400
Received: from sea2-dav3.sea2.hotmail.com ([207.68.164.107]:17937 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262108AbTJNVjS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 17:39:18 -0400
X-Originating-IP: [12.145.34.101]
X-Originating-Email: [san_madhav@hotmail.com]
From: "sankar" <san_madhav@hotmail.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       <linux-kernel@vger.kernel.org>
References: <A20D5638D741DD4DBAAB80A95012C0AED78649@orsmsx409.jf.intel.com>
Subject: Re: Question on atomic_inc/dec
Date: Tue, 14 Oct 2003 14:34:55 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <Sea2-DAV3c098V4p7Jl00002e3e@hotmail.com>
X-OriginalArrivalTime: 14 Oct 2003 21:39:13.0680 (UTC) FILETIME=[9C535900:01C3929B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thx for the reply...
The definition for atomic_inc() used to be there in asm/atomic.h on redhat
versions 7.2..
But on redhat ver 9.0 asm/atomic.h does not have the definition for
atomic_inc().
Is it moved to anyother file on redhat 9.0??

Pls reply...
----- Original Message -----
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "sankar" <san_madhav@hotmail.com>; <linux-kernel@vger.kernel.org>
Sent: Tuesday, October 14, 2003 2:17 PM
Subject: RE: Question on atomic_inc/dec


> From: sankar
>
> Hi,
> I have a question concerning the macro atomic_inc on REDHAT 9.0. I had
used
> atomic_inc on REDHAT 7.2 earlier. I installed redhat 9.0 and tried to run
my
> old code on this. I got the error saying atomic_inc not declared.
>
> I tried to search the header file in which this is defined but with
failure.

Seems you were using a kernel definition of a function (this
normally happens only because it was out there by mistake,
or because you had __KERNEL__ #defined).

It will be in include/asm/atomic.h; however, it is not wise to
use directly the kernel stuff unless you are coding kernel stuff.

You can always strip them, of course :)

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
