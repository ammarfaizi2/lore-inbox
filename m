Return-Path: <linux-kernel-owner+w=401wt.eu-S932434AbXAIWEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbXAIWEz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbXAIWEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:04:55 -0500
Received: from smtp.osdl.org ([65.172.181.24]:47400 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932434AbXAIWEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:04:54 -0500
Date: Tue, 9 Jan 2007 14:04:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, "Steven M. Christey" <coley@mitre.org>
Subject: Re: [2.6 patch] x86_64: re-add a newline to RESTORE_CONTEXT
Message-Id: <20070109140424.5f96de69.akpm@osdl.org>
In-Reply-To: <200701091201.21146.ak@suse.de>
References: <20070109025516.GC25007@stusta.de>
	<200701091201.21146.ak@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2007 12:01:21 +0100
Andi Kleen <ak@suse.de> wrote:

> On Tuesday 09 January 2007 03:55, Adrian Bunk wrote:
> > RESTORE_CONTEXT lost a newline in 
> > commit 658fdbef66e5e9be79b457edc2cbbb3add840aa9:
> > http://www.mail-archive.com/kgdb-bugreport@lists.sourceforge.net/msg00559.html
> 
> I don't think we should add such changes for external patchkits.
> 
> In general kgdb shouldn't add any patches at all. If the existing 
> hooks are not enough they should submit their changes needed so
> that it can just work.
> 

But the patch is a bugfix.  Without it, you cannot do

	RESTORE_CONTEXT	\
	.globl ...	\

Was the addition of this restriction to RESTORE_CONTEXT deliberate, or
mistaken?
