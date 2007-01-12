Return-Path: <linux-kernel-owner+w=401wt.eu-S1161046AbXALJWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161046AbXALJWr (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 04:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161047AbXALJWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 04:22:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:6428 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161046AbXALJWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 04:22:46 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=fzS7MnpC6h6sdv5aT4FlBe7DjjmlkP2WteyZl3ULv3rAxj6HSGOsu1UwDHVzkFBAZZRTcnUZo655kurYaBR2mVevnJzRejSUF8nymV9sAiWMmW/BW9vwgXvH35VWQMwhtfxp/XzWuMI7pNsOWeDGwHLgV3V02HRKiJW7tYI5/n0=
Message-ID: <84144f020701120122v4fdcc6a8l81053885256c1339@mail.gmail.com>
Date: Fri, 12 Jan 2007 11:22:40 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Subject: Re: [PATCH] slab: cache_grow cleanup
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com, clameter@sgi.com
In-Reply-To: <Pine.LNX.4.64.0701091539160.10824@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0701091539160.10824@sbz-30.cs.Helsinki.FI>
X-Google-Sender-Auth: 5939f655fa8aaf5c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 1/9/07, Pekka J Enberg <penberg@cs.helsinki.fi> wrote:
> From: Pekka Enberg <penberg@cs.helsinki.fi>
>
> The current implementation of cache_grow() has to either (1) use pre-allocated
> memory for the slab or (2) allocate the memory itself which makes the error
> paths messy. Move __GFP_NO_GROW and __GFP_WAIT processing to kmem_getpages()
> and introduce a new __cache_grow() variant that expects the memory for a new
> slab to always be handed over in the 'objp' parameter.
>
> Cc: Hugh Dickins <hugh@veritas.com>
> Cc: Christoph Lameter <clameter@sgi.com>
> Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

Can we get this into -mm, please?
