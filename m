Return-Path: <linux-kernel-owner+w=401wt.eu-S932491AbXAIW4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbXAIW4I (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbXAIW4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:56:07 -0500
Received: from smtp.osdl.org ([65.172.181.24]:50829 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932492AbXAIW4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:56:06 -0500
Date: Tue, 9 Jan 2007 14:52:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, "Steven M. Christey" <coley@mitre.org>
Subject: Re: [2.6 patch] x86_64: re-add a newline to RESTORE_CONTEXT
Message-Id: <20070109145247.1ffc0cd3.akpm@osdl.org>
In-Reply-To: <200701092343.01112.ak@suse.de>
References: <20070109025516.GC25007@stusta.de>
	<200701091201.21146.ak@suse.de>
	<20070109140424.5f96de69.akpm@osdl.org>
	<200701092343.01112.ak@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2007 23:43:00 +0100
Andi Kleen <ak@suse.de> wrote:

> 
> > 
> > But the patch is a bugfix.  Without it, you cannot do
> > 
> > 	RESTORE_CONTEXT	\
> > 	.globl ...	\
> > 
> > Was the addition of this restriction to RESTORE_CONTEXT deliberate, or
> > mistaken?
> 
> RESTORE_CONTEXT is a private macro and I don't see why we should
> support out of tree usages for that. As long as it works as it is 
> in the tree it is fine.
> 

In other words we'll leave it in its present buggy form so that it will
explode next time someone tries to use it for something new, rather than a)
fixing that potential problem and b) fixing a real problem with a popular
external GPLed product.

Unfathomable.
