Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264725AbUEEQjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264725AbUEEQjg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 12:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264728AbUEEQjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 12:39:36 -0400
Received: from ns.suse.de ([195.135.220.2]:22991 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264725AbUEEQjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 12:39:35 -0400
Date: Wed, 5 May 2004 18:39:34 +0200
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] NUMA API for Linux 5/ Add VMA hooks for policy
Message-ID: <20040505163934.GA14963@wotan.suse.de>
References: <20040406153322.5d6e986e.ak@suse.de> <20040406153713.52a64a26.ak@suse.de> <20040505090531.51ad5c89.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040505090531.51ad5c89.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks like you should do something equivalent to adding:
> 
>   #include <linux/mempolicy.h>
> 
> to the files:
> 
>   arch/ia64/ia32/binfmt_elf32.c
>   arch/ia64/kernel/perfmon.c
>   arch/ia64/mm/init.c
>   kernel/exit.c
> 
> The following, based off the numa-api-vma-policy-hooks patch in Andrew's
> latest 2.6.6-rc3-mm2, includes these additional includes, and builds
> successfully:

This is not needed, because mempolicy.h is included in mm.h, which
is included at some point by all of these.
Perhaps you missed a patch? (several of the patches depended on each other) 

-Andi
