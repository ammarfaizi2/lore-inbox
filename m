Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030695AbWKORBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030695AbWKORBk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030709AbWKORBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:01:40 -0500
Received: from extu-mxob-2.symantec.com ([216.10.194.135]:55712 "EHLO
	extu-mxob-2.symantec.com") by vger.kernel.org with ESMTP
	id S1030695AbWKORBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:01:39 -0500
X-AuditID: d80ac287-a28e6bb000005d67-b1-455b47f08001 
Date: Wed, 15 Nov 2006 17:01:54 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Jan Beulich <jbeulich@novell.com>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, patches@x86-64.org
Subject: Re: [PATCH] x86-64: adjust pmd_bad()
In-Reply-To: <455B3AF2.76E4.0078.0@novell.com>
Message-ID: <Pine.LNX.4.64.0611151658520.24160@blonde.wat.veritas.com>
References: <455B3AF2.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Nov 2006 17:01:36.0424 (UTC) FILETIME=[B5C9CA80:01C708D7]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006, Jan Beulich wrote:

> Make pmd_bad() symmetrical to pgd_bad() and pud_bad(). At once,
> simplify them all.

Symmetrical and simpler, yes, but you're weakening the pmd_bad() test:
no longer requires that all those _KERNPG_TABLE bits be set.  Wouldn't
it be better to go the other way and strengthen pgd_bad, pud_bad?

Hugh
