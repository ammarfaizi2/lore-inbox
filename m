Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271923AbRIEJ5X>; Wed, 5 Sep 2001 05:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271909AbRIEJ5M>; Wed, 5 Sep 2001 05:57:12 -0400
Received: from mail.webmaster.com ([216.152.64.131]:23967 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S271895AbRIEJ46>; Wed, 5 Sep 2001 05:56:58 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Alex Bligh - linux-kernel" <linux-kernel@alex.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.9-ac6
Date: Wed, 5 Sep 2001 02:57:17 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMAECKDLAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <1257554973.999687013@[169.254.198.40]>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >> 	I think, perhaps, the logic should be that a module
> >> shouldn't taint the kernel if:

> >> 	1) The user built the module from source on that machine, OR

> >> 	2) The module source is freely available without restriction

> > 	I just realized two things. One, there's a strong argument that this
> > should be an AND, not an OR.

> And as all distributions would fail (1) in initial form, all
> distributions would result in tainted kernels. Is this the
> intent?

	They wouldn't taint because the kernel signature would match the module
signatures. I provided more detail on one possible way this scheme would
work and it's not quite as simple as the summary above suggests.

	Basically, when you compile (or install) the kernel, a random 'signature'
goes in. When you compile a module, the signature goes in too. You can then
compare the module's signature to the kernel's signature to ensure they were
compiled as a unit. Unfortunately, this doesn't ensure that the user has the
source.

	I suppose, if the module source were freely available, then '2' would
apply. If you keep it as an OR, then distributions wouldn't taint out of the
box unless they included modules whose source distribution was limited. I
think this is what you want.

	DS

