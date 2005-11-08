Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965254AbVKHTIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965254AbVKHTIe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 14:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965255AbVKHTIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 14:08:34 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:50087 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965254AbVKHTId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 14:08:33 -0500
Message-ID: <4370F7AE.5090505@us.ibm.com>
Date: Tue, 08 Nov 2005 11:08:30 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
CC: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] Inline 3 functions
References: <436FF51D.8080509@us.ibm.com> <436FF894.8090204@us.ibm.com> <Pine.LNX.4.58.0511080937060.9530@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0511080937060.9530@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg wrote:
> On Mon, 7 Nov 2005, Matthew Dobson wrote:
> 
>>I found three functions in slab.c that have only 1 caller (kmem_getpages,
>>alloc_slabmgmt, and set_slab_attr), so let's inline them.
> 
> 
> Why? They aren't on the hot path and I don't see how this is an 
> improvement...
> 
> 			Pekka

Well, no, they aren't on the hot path.  I just figured since they are only
ever called from one other function, why not inline them?  If the sentiment
is that it's a BAD idea, I'll drop it.

-Matt
