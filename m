Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135637AbRDSMHp>; Thu, 19 Apr 2001 08:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135639AbRDSMHf>; Thu, 19 Apr 2001 08:07:35 -0400
Received: from shell.ca.us.webchat.org ([216.152.64.152]:6897 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S135637AbRDSMHP>; Thu, 19 Apr 2001 08:07:15 -0400
From: "David Schwartz" <davids@webmaster.com>
To: =?iso-8859-1?Q?=C9ric_Brunet?= <ebrunet@quatramaran.ens.fr>,
        <linux-kernel@vger.kernel.org>
Subject: RE: Children first in fork
Date: Thu, 19 Apr 2001 05:07:11 -0700
Message-ID: <NCBBLIEPOCNJOAEKBEAKAEEJOHAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20010419133538.A28654@quatramaran.ens.fr>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hello all,
>
> I have read on lwn.net that the patch that makes children run first after
> a fork has been integrated in the latest pre-kernel.
>
> I am a little bit concerned by that, as I have begun to write a program
> that monitors process using ptrace. The difficulty is to ptrace-attach
> the child in a fork before it can do anything unmonitored. When the
> parent runs first, the return from the fork system called is trapped by
> the monitor program which has enough time to ptrace-attach the child. If
> the child runs first, it is not even remotely the case anymore.
>
> I understand that performance is more important that the possibility to
> ptrace across forks, but I still think that there should be a way to
> attach the children of a ptraced-process. Is there currently a way to
> achieve this in the kernel that I am not aware of ?

	It seems to me that what you really want is a fork option to create the
child in a suspended state.

	DS

