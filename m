Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbUBXUBM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 15:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUBXUBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 15:01:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3777 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262424AbUBXUBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 15:01:07 -0500
Date: Tue, 24 Feb 2004 15:01:03 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Matt Mackall <mpm@selenic.com>
cc: Christophe Saout <christophe@saout.de>,
       Jean-Luc Cooke <jlcooke@certainkey.com>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, James Morris <jmorris@intercode.com.au>
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
In-Reply-To: <20040224191142.GT3883@waste.org>
Message-ID: <Xine.LNX.4.44.0402241457330.25785-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004, Matt Mackall wrote:

> Something like:
> 
>  /* calculate the size of a tfm so that users can manage their own
>  copies */
> 
>  int crypto_alg_size(const char *name);
> 
>  /* copy a TFM to a user-managed buffer, possibly on stack, with proper
>  internal reference counting and any other necessary magic, size checks
>  against boneheaded buffer sizing */
> 
>  crypto_copy_tfm(char *dst, const struct crypto_tfm *src, int size);

Does it need to be copied from an existing tfm?  I think it would be 
cleaner to provide just a way to initialize a tfm.

>  /* do all the necessary bookkeeping to release a user-managed TFM, use
>  char pointer to avoid alloc/free mismatch */
> 
>  crypto_copy_cleanup_tfm(char *usertfm);
> 

This is doable.


- James
-- 
James Morris
<jmorris@redhat.com>


