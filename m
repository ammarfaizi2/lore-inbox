Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWCAUbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWCAUbv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 15:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWCAUbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 15:31:51 -0500
Received: from kanga.kvack.org ([66.96.29.28]:50366 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751167AbWCAUbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 15:31:51 -0500
Date: Wed, 1 Mar 2006 15:26:34 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
Message-ID: <20060301202634.GC4081@kvack.org>
References: <1140841250.2587.33.camel@localhost.localdomain> <200603012027.55494.ak@suse.de> <1141242206.2899.109.camel@localhost.localdomain> <200603012049.32670.ak@suse.de> <1141243508.2899.126.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141243508.2899.126.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 12:05:07PM -0800, Bryan O'Sullivan wrote:
> This section also makes it clear yet again that wmb() is absolutely not
> sufficient to get program store order semantics in the presence of WC;
> you *have* to use an explicit synchronising instruction of some kind.

The semantics your code seems to care about are not those of a memory 
barrier (which deals with ordering), but of a flush of the write combining 
buffers.  That's an important high level distinction as they are implemented 
differently across architectures.  Please rename the macro something like 
flush_wc() and document it as such, at which point I remove my objection.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
