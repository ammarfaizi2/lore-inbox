Return-Path: <linux-kernel-owner+w=401wt.eu-S932476AbXAIWnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbXAIWnK (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbXAIWnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:43:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:51053 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932476AbXAIWnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:43:08 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] x86_64: re-add a newline to RESTORE_CONTEXT
Date: Tue, 9 Jan 2007 23:43:00 +0100
User-Agent: KMail/1.9.5
Cc: Adrian Bunk <bunk@stusta.de>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, "Steven M. Christey" <coley@mitre.org>
References: <20070109025516.GC25007@stusta.de> <200701091201.21146.ak@suse.de> <20070109140424.5f96de69.akpm@osdl.org>
In-Reply-To: <20070109140424.5f96de69.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701092343.01112.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> But the patch is a bugfix.  Without it, you cannot do
> 
> 	RESTORE_CONTEXT	\
> 	.globl ...	\
> 
> Was the addition of this restriction to RESTORE_CONTEXT deliberate, or
> mistaken?

RESTORE_CONTEXT is a private macro and I don't see why we should
support out of tree usages for that. As long as it works as it is 
in the tree it is fine.

-Andi
