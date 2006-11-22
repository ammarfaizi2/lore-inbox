Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755122AbWKVMnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122AbWKVMnx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 07:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755641AbWKVMnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 07:43:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:25793 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1755122AbWKVMnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 07:43:52 -0500
To: "d binderman" <dcb314@hotmail.com>
Cc: linux-kernel@vger.kernel.org, mel@csn.ul.ie
Subject: Re: arch/x86_64/mm/numa.c(124): remark #593: variable "bootmap_size" was set but nev
References: <BAY107-F11C5D88BF00FBB291F3FC09CE30@phx.gbl>
From: Andi Kleen <ak@suse.de>
Date: 22 Nov 2006 13:43:40 +0100
In-Reply-To: <BAY107-F11C5D88BF00FBB291F3FC09CE30@phx.gbl>
Message-ID: <p73mz6j8xdv.fsf@bingen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"d binderman" <dcb314@hotmail.com> writes:

> Hello there,
> 
> I just tried to compile Linux kernel 2.6.18.3 with the Intel C
> C compiler.
> 
> The compiler said
> 
> arch/x86_64/mm/numa.c(124): remark #593: variable "bootmap_size" was
> set but never used

Actually it looks like a real bug -- probably added recently with the
new bootmap code.

The bootmap should be reserved based on that size.

-Andi

