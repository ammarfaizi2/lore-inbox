Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287827AbSABPHg>; Wed, 2 Jan 2002 10:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287834AbSABPH0>; Wed, 2 Jan 2002 10:07:26 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:30732 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S287827AbSABPHR>; Wed, 2 Jan 2002 10:07:17 -0500
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: <hauan@cmu.edu>
Cc: <knobi@knobisoft.de>, <linux-kernel@vger.kernel.org>
Subject: RE: smp cputime issues
Date: Wed, 2 Jan 2002 07:07:03 -0800
Message-ID: <HBEHIIBBKKNOBLMPKCBBIEBLEFAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3C33071A.EB4943E8@sirius-cafe.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Second - you mention that you see the effect mainly on linear algebra
> stuff. Could it be that you are memory bandwidth limited if you run two
> of them together? Are you using Intel CPUs (my guess) which have the FSB
> concept that may make memory bandwidth scaling a problem, or AMD Athlons
> which use the Alpha/EV6 bus and should be a bit more friendly.

Hmmm ... linear algebra ... are you by any chance using Atlas? Atlas is
highly optimized for the chips and as many other architectural features as
it can discover, such as cache size. I'm sure a well-tuned Atlas application
is quite capable of bending a machine to its own purposes, quite possibly
to the discomfort of other users attempting to use the system. If the issue
is sharing of resources between the linear algebra code and other users,
perhaps the thing to do is get Atlas, if you're not currently using it,
and then "nice" the linear algebra code.

I run Atlas on my (UP) 1.333 GHz Athlon Thunderbird and it screams. I can
get 4+ GFLOPS in the 3DNOW 32-bit code and well over 1 GFLOP in 64 bits.
--
M. Edward Borasky

znmeb@borasky-research.net
http://www.borasky-research.net

