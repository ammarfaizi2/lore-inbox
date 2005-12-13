Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbVLMA5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVLMA5l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 19:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbVLMA5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 19:57:41 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:4852 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932305AbVLMA5k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 19:57:40 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Daniel Walker <dwalker@mvista.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 16:57:38 -0800
Message-Id: <1134435458.22269.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-12 at 23:45 +0000, David Howells wrote:

>  (1) Provides a simple xchg() based semaphore as a default for all
>      architectures that don't wish to override it and provide their own.
> 
>      Overriding is possible by setting CONFIG_ARCH_IMPLEMENTS_MUTEX and
>      supplying asm/mutex.h
> 
>      Partial overriding is possible by #defining mutex_grab(), mutex_release()
>      and is_mutex_locked() to perform the appropriate optimised functions.

Your code is really similar to the RT mutex, which does everything that
your mutex does at least ? Assuming you've reviewed the RT mutex, why
would we want to use yours over it?

Daniel

