Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030730AbWKORX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030730AbWKORX1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030728AbWKORX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:23:26 -0500
Received: from ns2.suse.de ([195.135.220.15]:8650 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030730AbWKORX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:23:26 -0500
From: Andi Kleen <ak@suse.de>
To: patches@x86-64.org
Subject: Re: [patches] Re: [PATCH] x86-64: adjust pmd_bad()
Date: Wed, 15 Nov 2006 18:23:20 +0100
User-Agent: KMail/1.9.5
Cc: Hugh Dickins <hugh@veritas.com>, Jan Beulich <jbeulich@novell.com>,
       linux-kernel@vger.kernel.org
References: <455B3AF2.76E4.0078.0@novell.com> <Pine.LNX.4.64.0611151658520.24160@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0611151658520.24160@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611151823.20520.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 18:01, Hugh Dickins wrote:
> On Wed, 15 Nov 2006, Jan Beulich wrote:
> 
> > Make pmd_bad() symmetrical to pgd_bad() and pud_bad(). At once,
> > simplify them all.
> 
> Symmetrical and simpler, yes, but you're weakening the pmd_bad() test:
> no longer requires that all those _KERNPG_TABLE bits be set.  Wouldn't
> it be better to go the other way and strengthen pgd_bad, pud_bad?

That's a good point. Yes that would be better.  If it works :) 

They can't be completely the same because we don't set large page bits on
PGDs (on PUDs we will eventually with 1GB pages) 

-Andi
