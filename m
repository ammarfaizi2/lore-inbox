Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUDGVsz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 17:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264187AbUDGVsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 17:48:54 -0400
Received: from ns.suse.de ([195.135.220.2]:4293 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261169AbUDGVr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 17:47:57 -0400
Date: Wed, 7 Apr 2004 23:47:51 +0200
From: Andi Kleen <ak@suse.de>
To: Anton Blanchard <anton@samba.org>
Cc: david@gibson.dropbear.id.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org, paulus@samba.org,
       linuxppc64-dev@lists.linuxppc.org
Subject: Re: RFC: COW for hugepages
Message-Id: <20040407234751.4c652283.ak@suse.de>
In-Reply-To: <20040407214116.GA18493@krispykreme>
References: <20040407074239.GG18264@zax>
	<20040407143447.4d8f08af.ak@suse.de>
	<20040407142748.GO26474@krispykreme>
	<20040407165041.23d8d82a.ak@suse.de>
	<20040407214116.GA18493@krispykreme>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2004 07:41:16 +1000
Anton Blanchard <anton@samba.org> wrote:

>  
> > All they did was to modify the code to lazy faulting. That is
> > architecture specific
> > 
> > (and add the mpol code, but that was pretty minor) 
> > 
> > COW is a different thing though.
> 
> Why is it architecture specific? I dont understand why you cant make
> lazy faulting common code.

My understanding was that you needed special magic on IA64 and PPC64. If that's
wrong you can probably do it, but you may need new TLB flush primitives.

-Andi
