Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbTJDJQv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 05:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbTJDJQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 05:16:51 -0400
Received: from colin2.muc.de ([193.149.48.15]:5645 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261962AbTJDJQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 05:16:50 -0400
Date: 4 Oct 2003 11:17:03 +0200
Date: Sat, 4 Oct 2003 11:17:03 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Andi Kleen <ak@muc.de>, Joe Korty <joe.korty@ccur.com>,
       linux-kernel@vger.kernel.org
Subject: Re: mlockall and mmap of IO devices don't mix
Message-ID: <20031004091703.GB23306@colin2.muc.de>
References: <CFYv.787.23@gated-at.bofh.it> <m34qyp7ae4.fsf@averell.firstfloor.org> <200310041047.56705.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310041047.56705.ioe-lkml@rameria.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This check is only done, if it is a valid pfn (pfn_valid()) of a present
> pte.

pfn_valid is useless, it doesn't handle all IO holes on x86 for examples.

-Andi
