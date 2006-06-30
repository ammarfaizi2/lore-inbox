Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWF3M1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWF3M1T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 08:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbWF3M1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 08:27:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:46810 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932222AbWF3M1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 08:27:18 -0400
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: eranian@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/17] 2.6.17.1 perfmon2 patch for review: PMU context switch
References: <200606230913.k5N9D73v032387@frankl.hpl.hp.com>
From: Andi Kleen <ak@suse.de>
Date: 30 Jun 2006 14:27:16 +0200
In-Reply-To: <200606230913.k5N9D73v032387@frankl.hpl.hp.com>
Message-ID: <p73fyhmx1zv.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Eranian <eranian@frankl.hpl.hp.com> writes:

> This patch contains the PMU context switch routines.

Description/why/what etc. missing.

<quick look>

This is all unconditionally called at context switch?!??

No way this can be merged. It needs to be zero cost for any process
that doesn't use perfmon and even for those it probably needs 
some tuning.

See my earlier mail on how to make it zero cost for i386/x86-64.

Please don't submit such horrible code again.

-Andi

