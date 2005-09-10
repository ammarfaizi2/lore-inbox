Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVIJJeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVIJJeJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 05:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVIJJeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 05:34:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32727 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750721AbVIJJeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 05:34:08 -0400
Date: Sat, 10 Sep 2005 02:33:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: NUMA mempolicy /proc code in mainline shouldn't have been
 merged
Message-Id: <20050910023337.7b79db9a.akpm@osdl.org>
In-Reply-To: <200509101120.19236.ak@suse.de>
References: <200509101120.19236.ak@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
>  Just noticed the ugly SGI /proc/*/numa_maps code got merged.

Been in -mm for over two months.

>  I argued several times against it

OK, I either didn't notice or forgot to make a note of that.

> and I very deliberately didn't include
>  a similar facility when I wrote the NUMA policy code because it's a bad
>  idea.
> 
> 
>  - it's a lot of ugly code.
>  - it's basically only a debugging hack right now
>  - it presents lots of kernel internal information and mempolicy
>  internals (like how many people have a page mapped) etc.
>  to userland that shouldn't be exposed to this.
>  - the format is very complicated and the chance of bug free
>  userland parsers of this is near zero.
>  - there is no demonstrated application that needs it
>  (there was a theoretical usecase where it might be needed,
>  but there were better solutions proposed for this) 
> 
> 
>  Can the patch please be removed? 

OK by me.  I queued a revert patch.
