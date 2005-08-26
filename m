Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbVHZHD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbVHZHD3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 03:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbVHZHD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 03:03:28 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:10702 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932537AbVHZHD2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 03:03:28 -0400
Date: Fri, 26 Aug 2005 10:03:01 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: [PATCH 2/2] pipe: do not return POLLERR for fifo_poll
In-Reply-To: <20050825170217.666edda3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0508261000310.26177@sbz-30.cs.Helsinki.FI>
References: <ilomk8.i0yljb.2ul6sqfgelx5ik5dngkbmbkeu.beaver@cs.helsinki.fi>
 <ilomki.fs3loe.5j02sm6rx63x13ip2d9643lta.beaver@cs.helsinki.fi>
 <20050825170217.666edda3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> > This patch changes fifo_poll not to return POLLERR to take care of a FIXME
> > in fs/pipe.c stating that "Most unices do not set POLLERR for fifos." The
> > comment has been there since 2.3.99-pre3 so either apply this patch or
> > alternatively, I can send a new one removing the unnecessary abstraction.

On Thu, 25 Aug 2005, Andrew Morton wrote:
> A userspace-visible change, no?
> 
> So there's a risk in changing it.  What do we get in return?  Worried.

FWIW I have been running on this for few days now without any noticeable 
regressions.  We get a solved FIXME in return but like I said I am a happy 
to remove the redundant abstraction if this is too risky.

			Pekka
