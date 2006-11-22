Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757053AbWKVVkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757053AbWKVVkV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 16:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757056AbWKVVkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 16:40:21 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:16844 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1757051AbWKVVkU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 16:40:20 -0500
Date: Wed, 22 Nov 2006 21:40:09 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org,
       David Miller <davem@davemloft.net>
Subject: Re: [PATCH] dont insert pipe dentries into dentry_hashtable.
Message-ID: <20061122214009.GH3078@ftp.linux.org.uk>
References: <a769871e0611211233n20eb9d74j661cd73e9315fade@mail.gmail.com> <20061121224613.548207f9.akpm@osdl.org> <200611221602.29597.dada1@cosmosbay.com> <200611221848.41330.dada1@cosmosbay.com> <20061122133618.da95e48e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061122133618.da95e48e.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 01:36:18PM -0800, Andrew Morton wrote:
> The DCACHE_UNHASHED games seem hacky.
> 
> Would it be cleaner to define a new dentry.d_flags bit which can be used to
> indicate that this is a hashing-not-needed dentry, and to handle that over
> in dcache.c?

Much more invasive change, actually, and on fairly hot paths.
