Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbTINAIV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 20:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbTINAIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 20:08:21 -0400
Received: from zero.aec.at ([193.170.194.10]:12806 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262264AbTINAIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 20:08:20 -0400
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
From: Andi Kleen <ak@muc.de>
Date: Sun, 14 Sep 2003 02:07:04 +0200
In-Reply-To: <vqKS.2NP.29@gated-at.bofh.it> (Adrian Bunk's message of "Sun,
 14 Sep 2003 00:10:19 +0200")
Message-ID: <m3y8ws6xnb.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <viay.6qh.11@gated-at.bofh.it> <vli4.2Ml.15@gated-at.bofh.it>
	<vnjR.5Sn.5@gated-at.bofh.it> <vnD7.6jK.1@gated-at.bofh.it>
	<vnMX.6x0.17@gated-at.bofh.it> <vqKS.2NP.29@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> writes:
>
> I don't like the current user interface that says "if you want to 
> support both an Athlon and a Pentium 4 in your kernel use the Pentium III
> option. And for better optimization, also check the "generic" option".

The big issue with your ifdefing of workarounds is that it causes subtle 
support problems. A lot of settings for specific CPUs boot and work
fine on other CPUs (possibly with small performance impact, but they're
rarely noticeable without explicit benchmarking). Just when you don't 
include the workarounds for the bugs on these other CPUs it will boot and 
even run, but fail mysteriously once a month. And that would be a support 
nightmare.

-Andi
