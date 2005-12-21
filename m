Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbVLUOSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbVLUOSU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 09:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbVLUOSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 09:18:20 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:1952 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S932425AbVLUOST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 09:18:19 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17321.25650.271585.790597@gargle.gargle.HOWL>
Date: Wed, 21 Dec 2005 17:18:26 +0300
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: "Mike Snitzer" <snitzer@gmail.com>, "Adrian Bunk" <bunk@stusta.de>,
       "Mark Lord" <lkml@rtr.ca>, "J.A. Magallon" <jamagallon@able.es>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>, <nel@vger.kernel.org>,
       <mpm@selenic.com>
Subject: Re: About 4k kernel stack size....
In-Reply-To: <Pine.LNX.4.61.0512210901340.11568@chaos.analogic.com>
References: <20051218231401.6ded8de2@werewolf.auna.net>
	<43A77205.2040306@rtr.ca>
	<20051220133729.GC6789@stusta.de>
	<170fa0d20512200637l169654c9vbe38c9931c23dfb1@mail.gmail.com>
	<46578.10.10.10.28.1135094132.squirrel@linux1>
	<Pine.LNX.4.61.0512201202090.27692@chaos.analogic.com>
	<17320.35736.89250.390950@gargle.gargle.HOWL>
	<Pine.LNX.4.61.0512210901340.11568@chaos.analogic.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) writes:
 > 
 > On Tue, 20 Dec 2005, Nikita Danilov wrote:
 > 
 > > linux-os \(Dick Johnson\) writes:
 > > >
 > >
 > > [...]
 > >
 > > > See, isn't rule-making fun? This whole 4k stack-
 > > > thing is really dumb. Other operating systems
 > > > use paged virtual memory for stacks, except
 > > > for the interrupt stack. If Linux used paged
 > > > virtual memory for stacks,
 > >
 > > ... then spin-locks couldn't be held across function calls.
 > >
 > 
 > Sure they can! In ix86 machines the local 'cli' within the

Sure they cannot: one cannot schedule with spin-lock held, and major
page fault will block for IO.

[...]

 > 
 > NT is a poor copy of VAX/VMS. The DIGITAL Project Engineer for
 > VAX/VMS was hired as a consultant by Microsoft to develop it.

Thank you, I know who D. Cutler is, and I have used RSX11/RT11/VMS, and
I am choosing Linux because of its technical superiority.

[...]

 > 

Nikita.
