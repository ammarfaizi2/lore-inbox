Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVA1IU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVA1IU0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 03:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVA1IU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 03:20:26 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:24219
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261192AbVA1IUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 03:20:14 -0500
Subject: Re: High resolution timers and BH processing on -RT
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: George Anzinger <george@mvista.com>, LKML <linux-kernel@vger.kernel.org>,
       Doug Niehaus <niehaus@ittc.ku.edu>,
       Benedikt Spranger <bene@linutronix.de>
In-Reply-To: <20050128044301.GD29751@elte.hu>
References: <1106871192.21196.152.camel@tglx.tec.linutronix.de>
	 <20050128044301.GD29751@elte.hu>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 09:20:10 +0100
Message-Id: <1106900411.21196.181.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-28 at 05:43 +0100, Ingo Molnar wrote:
> * 
> is this due to algorithmic/PIT-programming overhead, or due to the noise
> introduced by other, non-hard-RT timers? I'd guess the later from the
> looks of it, but did your test introduce such noise (via networking and
> application workloads?).
> 

Right, it's due to noise by non-RT timers, which I enforced by adding
networking and applications.

This adds random timer expires and admittedly the PIT reprogramming
overhead is adding portions of that noise.

tglx


