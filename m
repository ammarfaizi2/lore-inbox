Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264397AbTLRFZU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 00:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264468AbTLRFZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 00:25:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:34270 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264397AbTLRFZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 00:25:17 -0500
Date: Wed, 17 Dec 2003 21:25:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mark Frazer <mark@mjfrazer.org>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Missing up_read after get_user_pages in arch/i386/lib/usercopy.c?
In-Reply-To: <20031218000249.A25268@mjfrazer.org>
Message-ID: <Pine.LNX.4.58.0312172122490.6211@home.osdl.org>
References: <20031218000249.A25268@mjfrazer.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Dec 2003, Mark Frazer wrote:
>
> Just browsing users of get_user_pages today and noticed what might be a
> bug.

Looks like it. It can only hit old 80386 machines (that code is disabled
by any CPU with a i486 MMU or better), and even then only when somebody
does something silly, but yeah, looks like a real bug.

		Linus
