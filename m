Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbWJJThx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbWJJThx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 15:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWJJThx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 15:37:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18654 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030226AbWJJThw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 15:37:52 -0400
Date: Tue, 10 Oct 2006 12:37:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: "David S. Miller" <davem@sunset.davemloft.net>,
       linux-kernel@vger.kernel.org,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Sparc64 stopped building - sigset_t unrecognized in compat.h
Message-Id: <20061010123744.403dbea7.akpm@osdl.org>
In-Reply-To: <20061010115940.4c25ae83.pj@sgi.com>
References: <20061010115940.4c25ae83.pj@sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 11:59:40 -0700
Paul Jackson <pj@sgi.com> wrote:

> Sometime on or about the change to include/linux/compat.h:
> 
>     changeset:   39069:fefadae8104d
>     parent:      38900:a2856d056930
>     user:        David S. Miller <davem@sunset.davemloft.net>
>     date:        Tue Oct  3 04:24:18 2006 +0700
>     summary:     [SPARC64]: Move signal compat bits to new header file.
> 
> which added the line:
> 
>     extern void sigset_from_compat(sigset_t *set, compat_sigset_t *compat);
> 
> my crosstool compile of sparc64 for 2.6.18-mm3 stopped building.

That build error came from the CONFIG_BLOCK patches and Dave's change was
intended to fix it rather than creating it.

2.6.19-rc1-mm1 builds OK on sparc64.
