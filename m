Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWJJTgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWJJTgo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 15:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbWJJTgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 15:36:44 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:20868
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030225AbWJJTgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 15:36:43 -0400
Date: Tue, 10 Oct 2006 12:36:44 -0700 (PDT)
Message-Id: <20061010.123644.10299128.davem@davemloft.net>
To: pj@sgi.com
Cc: davem@sunset.davemloft.net, linux-kernel@vger.kernel.org,
       vonbrand@inf.utfsm.cl, akpm@osdl.org
Subject: Re: Sparc64 stopped building - sigset_t unrecognized in compat.h
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061010115940.4c25ae83.pj@sgi.com>
References: <20061010115940.4c25ae83.pj@sgi.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>
Date: Tue, 10 Oct 2006 11:59:40 -0700

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

And then there is a changeset I made right after that one which
fixes the build by removing the asm/signal.h include from asm/compat.h.
