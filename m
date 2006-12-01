Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031703AbWLABTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031703AbWLABTo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 20:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031705AbWLABTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 20:19:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:54879 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1031700AbWLABTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 20:19:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KU6KUDtf4Jm+U+umyQqEML90mwXznzUu1p0KcgRUgaqWLZgRshY1o6xwPM9eOYZlnnw2a3AqVvk3si9I60ScfhP3Im9T4vRJb7AkaqHopR4u/H2jf/q5Rg+8nEjWYhxFjKLXqTSYlN67d5T4VffPWfqNyNkh9L1Sq1+D1YTKIn0=
Message-ID: <e9c3a7c20611301719y63f64b04m9f748f91766c7ff@mail.gmail.com>
Date: Thu, 30 Nov 2006 18:19:40 -0700
From: "Dan Williams" <dan.j.williams@gmail.com>
To: neilb@suse.de, jeff@garzik.org, christopher.leech@intel.com, akpm@osdl.org
Subject: Re: [PATCH 02/12] dmaengine: add the async_tx api
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, olof@lixom.net
In-Reply-To: <20061130201010.21313.53627.stgit@dwillia2-linux.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e9c3a7c20611301155p4069c642j276d7705b0f81447@mail.gmail.com>
	 <20061130201010.21313.53627.stgit@dwillia2-linux.ch.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static inline void
> +do_sync_xor(struct page *dest, struct page **src_list, unsigned int offset,
> +       unsigned int src_cnt, size_t len, enum async_tx_flags flags,
> +       struct dma_async_tx_descriptor *depend_tx,
> +       dma_async_tx_callback callback, void *callback_param)
> +{
> +       void *_dest;
> +       int start_idx, i;
> +
> +       printk("%s: len: %u\n", __FUNCTION__, len);
Sorry, this should be PRINTK.

Dan
