Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVEBScE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVEBScE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 14:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVEBScE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 14:32:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:32420 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261569AbVEBScB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 14:32:01 -0400
Date: Mon, 2 May 2005 11:31:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: venkatesh.pallipadi@intel.com, racing.guo@intel.com, luming.yu@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]porting lockless mce from x86_64 to i386
Message-Id: <20050502113125.19320ceb.akpm@osdl.org>
In-Reply-To: <20050502171551.GG27150@muc.de>
References: <88056F38E9E48644A0F562A38C64FB60049EED02@scsmsx403.amr.corp.intel.com>
	<20050502171551.GG27150@muc.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
>  > 
>  > Doing it either way should be OK with this mce code. But I feel, 
>  > despite of the patch size, it is better to keep all the shared 
>  > code in i386 tree and link it from x86-64. Otherwise, it may become 
>  > kind of messy in future, with various links between i386 and x86-64.
> 
>  i386 already uses code from x86-64 (earlyprintk.c) - it is nothing 
>  new.

I must say I don't like the bidirectional sharing either.

But I guess it'll be simple enough to fix up if it causes any real problems
in the future.

