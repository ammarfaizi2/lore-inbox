Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751779AbVLBLgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbVLBLgo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 06:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbVLBLgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 06:36:44 -0500
Received: from mx1.suse.de ([195.135.220.2]:18328 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751779AbVLBLgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 06:36:43 -0500
Date: Fri, 2 Dec 2005 12:36:42 +0100
From: Andi Kleen <ak@suse.de>
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       perfctr-devel@lists.sourceforge.net
Subject: Re: [discuss] Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
Message-ID: <20051202113642.GK997@wotan.suse.de>
References: <20051129181344.GN19515@wotan.suse.de> <1133300591.3271.1.camel@entropy> <20051129215207.GR19515@wotan.suse.de> <20051129221915.GA6953@frankl.hpl.hp.com> <20051129225155.GT19515@wotan.suse.de> <20051130160159.GB8511@frankl.hpl.hp.com> <20051130162314.GP19515@wotan.suse.de> <20051201234150.GE3291@frankl.hpl.hp.com> <20051202000737.GG997@wotan.suse.de> <20051202070931.GA3819@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051202070931.GA3819@frankl.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 11:09:31PM -0800, Stephane Eranian wrote:
> But the interrupt is programmed for all counters. So by forcing the PMU
> interrupt to use the NMI vector then any perfmon interface would have to use

That is how it works yes. oprofile also uses NMIs.

> this interrupt as well. That will break the whole thing because in many
> places we rely on PMU interrupt being off.

If you rely on that then your subsystem is not usable on x86/x86-64.

-Andi
