Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbTINANz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 20:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbTINANz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 20:13:55 -0400
Received: from [209.195.52.120] ([209.195.52.120]:30443 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262268AbTINANy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 20:13:54 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Andi Kleen <ak@muc.de>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Date: Sat, 13 Sep 2003 17:10:27 -0700 (PDT)
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
In-Reply-To: <m3y8ws6xnb.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.58.0309131708440.27266@dlang.diginsite.com>
References: <viay.6qh.11@gated-at.bofh.it> <vli4.2Ml.15@gated-at.bofh.it>
 <vnjR.5Sn.5@gated-at.bofh.it> <vnD7.6jK.1@gated-at.bofh.it>
 <vnMX.6x0.17@gated-at.bofh.it> <vqKS.2NP.29@gated-at.bofh.it>
 <m3y8ws6xnb.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Sep 2003, Andi Kleen wrote:

> Adrian Bunk <bunk@fs.tum.de> writes:
> >
> > I don't like the current user interface that says "if you want to
> > support both an Athlon and a Pentium 4 in your kernel use the Pentium III
> > option. And for better optimization, also check the "generic" option".
>
> The big issue with your ifdefing of workarounds is that it causes subtle
> support problems. A lot of settings for specific CPUs boot and work
> fine on other CPUs (possibly with small performance impact, but they're
> rarely noticeable without explicit benchmarking). Just when you don't
> include the workarounds for the bugs on these other CPUs it will boot and
> even run, but fail mysteriously once a month. And that would be a support
> nightmare.
>

it sounds like a nessasary part of this patch would be to detect the CPU
type and complain VERY loudly if it's not one supported by the build.

This is probably a good idea anyway.

David Lang
