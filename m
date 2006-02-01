Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbWBAQ31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbWBAQ31 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 11:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbWBAQ30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 11:29:26 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:29879 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964989AbWBAQ3Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 11:29:25 -0500
Subject: Re: 2.6.16rc1-git4 slab corruption.
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Dave Jones <davej@redhat.com>
Cc: Chris Mason <mason@suse.com>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060201160921.GC5875@redhat.com>
References: <20060131180319.GA18948@redhat.com>
	 <200601311408.35771.mason@suse.com> <20060131221542.GC29937@redhat.com>
	 <84144f020601312327t490dcf4fi6fb09942a0f3dd87@mail.gmail.com>
	 <20060201160921.GC5875@redhat.com>
Date: Wed, 01 Feb 2006 18:29:24 +0200
Message-Id: <1138811364.8604.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Wed, 2006-02-01 at 11:09 -0500, Dave Jones wrote:
> @@ -1446,7 +1448,11 @@ next:
>  	} 
>  
>  	cachep->lists.next_reap = jiffies + REAPTIMEOUT_LIST3 +
> -					((unsigned long)cachep)%REAPTIMEOUT_LIST3;
> +					((unsigned long)cachep/L1_CACHE_BYTES)%REAPTIMEOUT_LIST3;

Hmm. This bit seems unrelated. Was it in the original patch?

			Pekka

