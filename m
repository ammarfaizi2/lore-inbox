Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267868AbUHKBnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267868AbUHKBnO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 21:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267869AbUHKBnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 21:43:14 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:29169 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267868AbUHKBnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 21:43:13 -0400
Date: Tue, 10 Aug 2004 21:47:05 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [PATCH][2.6] fix i386 idle routine selection
In-Reply-To: <88056F38E9E48644A0F562A38C64FB600296CC37@scsmsx403.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.58.0408102140260.2544@montezuma.fsmlabs.com>
References: <88056F38E9E48644A0F562A38C64FB600296CC37@scsmsx403.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Venkatesh,

On Tue, 10 Aug 2004, Pallipadi, Venkatesh wrote:

> The original idea of setting it back to default_idle(),
> was to handle the cases:
> 1) CPU 0 says it can do mwait and CPU 1 later says it
> cannot do mwait
> 2) CPU 0 says it cannot do mwait and later CPU 1 says
> that it can do mwait
>
> Not that I know of any system like that. But, ideally
> mwait_idle should be set only when all CPUs say that
> they can do it.

Hmm. Something like mwait/monitor really should be supported on all
processors in a system running the same executive, if you do happen to
come across a system with mixed capabilities then we should clear the
capability during the processor setup so that we never even select the
mwait idle. So we should defer handling such a scenario until someone
ships something, but generally the lowest common denominator with
respect to capabilities should be the BSP.

Thanks,
	Zwane
