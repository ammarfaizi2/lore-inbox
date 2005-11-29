Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbVK2VnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbVK2VnY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 16:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVK2VnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 16:43:24 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:22265 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932431AbVK2VnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 16:43:23 -0500
Subject: Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
From: Nicholas Miell <nmiell@comcast.net>
To: Andi Kleen <ak@suse.de>
Cc: Stephane Eranian <eranian@hpl.hp.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
In-Reply-To: <20051129181344.GN19515@wotan.suse.de>
References: <20051129151515.GG19515@wotan.suse.de>
	 <200511291056.32455.raybry@mpdtxmail.amd.com>
	 <20051129180903.GB6611@frankl.hpl.hp.com>
	 <20051129181344.GN19515@wotan.suse.de>
Content-Type: text/plain
Date: Tue, 29 Nov 2005 13:43:11 -0800
Message-Id: <1133300591.3271.1.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-29 at 19:13 +0100, Andi Kleen wrote:
> > Where did you see that PMC0 (PERSEL0/PERFCTR0) can only be programmed
> > to count cpu cycles (i.e. cpu_clk_unhalted)? As far as I can tell from
> > the documentation, the 4 counters are symetrical and can measure
> > any event that the processor offers.
> 
> Linux NMI watchdog does that.
> 
> All other perfctr users are supposed to keep their fingers away 
> from the watchdog (it looks like oprofile doesn't but not for much
> longer ...) 

Why? Hardcoding PMC 0 to be a cycle counter seems to be a waste of a
perfectly usable performance counter. What if I want to profile four
things, none of them requiring a cycle count?

-- 
Nicholas Miell <nmiell@comcast.net>

