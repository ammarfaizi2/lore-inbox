Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424064AbWKQBWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424064AbWKQBWd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 20:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424873AbWKQBWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 20:22:32 -0500
Received: from gw.goop.org ([64.81.55.164]:26820 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1424064AbWKQBWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 20:22:31 -0500
Message-ID: <455D11B9.4080302@goop.org>
Date: Thu, 16 Nov 2006 17:34:49 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: eranian@hpl.hp.com
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] i386 add Intel PEBS and BTS cpufeature bits and detection
References: <20061115213241.GC17238@frankl.hpl.hp.com>
In-Reply-To: <20061115213241.GC17238@frankl.hpl.hp.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Eranian wrote:
> Here is a small patch that adds two cpufeature bits to represent
> Intel's Precise-Event-Based Sampling (PEBS) and Branch Trace Store
> (BTS) features. Those features can be found on Intel P4 and Core 2 
> processors among others and can be used by perfmon.
>   

I've been thinking it would be useful for kernel debugging if kernel
oops messages could use the branch history to show the last few jumps on
processors which support it.  It would help a lot with the "oh, an oops
with eip==esp==0" type crashes, which are otherwise pretty unhelpful.

Do you think that would be easy/possible to support?  Would it interfere
with other uses of these features?

    J
