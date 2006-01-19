Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161210AbWASSwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161210AbWASSwE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 13:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161220AbWASSwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 13:52:04 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:24529 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1161243AbWASSwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 13:52:01 -0500
Date: Thu, 19 Jan 2006 14:43:56 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 8/8] uml: avoid "CONFIG_NR_CPUS undeclared" bogus error messages
Message-ID: <20060119194356.GA8670@ccure.user-mode-linux.org>
References: <20060118235132.4626.74049.stgit@zion.home.lan> <20060118235522.4626.2825.stgit@zion.home.lan> <20060119042104.GC8265@ccure.user-mode-linux.org> <200601191601.31805.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601191601.31805.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 04:01:28PM +0100, Blaisorblade wrote:
> Gerd Knorr in his tty patch, instead, used forward declarations, like:
> 
> struct task_struct; 
> 
> what about that?

I don't think so.  At least when you use void *, you are using a type
that's not incorrect.  In userspace code, those task_structs start
referring to host task_structs, which is definitely very wrong.

> Those functions probably should be moved anyway because they're
> useless there

Yeah.

				Jeff
