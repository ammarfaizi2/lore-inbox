Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbTJAHPl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 03:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbTJAHPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 03:15:41 -0400
Received: from ns.suse.de ([195.135.220.2]:34267 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261938AbTJAHPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 03:15:40 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
References: <7F740D512C7C1046AB53446D3720017304AFCF@scsmsx402.sc.intel.com.suse.lists.linux.kernel>
	<20031001053833.GB1131@mail.shareable.org.suse.lists.linux.kernel>
	<20030930224853.15073447.akpm@osdl.org.suse.lists.linux.kernel>
	<20031001061348.GE1131@mail.shareable.org.suse.lists.linux.kernel>
	<20030930233258.37ed9f7f.akpm@osdl.org.suse.lists.linux.kernel>
	<20031001065705.GI1131@mail.shareable.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 01 Oct 2003 09:15:37 +0200
In-Reply-To: <20031001065705.GI1131@mail.shareable.org.suse.lists.linux.kernel>
Message-ID: <p73fzidzaw6.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> 
> Btw, does anyone know if the "prefetchw" instruction is affected by
> the erratum?  I see that in current 2.6, only the "prefetchnta"
> instruction is disabled so presumably "prefetchw" is ok?

All prefetch instructions on Athlon/Opteron including prefetchw have the 
problem. prefetchw requires a store instead of a load to hit it though.

-Andi
