Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVBAETO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVBAETO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 23:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVBAETO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 23:19:14 -0500
Received: from waste.org ([216.27.176.166]:33422 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261537AbVBAETL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 23:19:11 -0500
Date: Mon, 31 Jan 2005 20:18:58 -0800
From: Matt Mackall <mpm@selenic.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] base-small: CONFIG_BASE_SMALL for small systems
Message-ID: <20050201041858.GT2891@waste.org>
References: <1.687457650@selenic.com> <200502010055.j110tWbd022651@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502010055.j110tWbd022651@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 09:55:32PM -0300, Horst von Brand wrote:
> Matt Mackall <mpm@selenic.com> said:
> > This patch series introduced a new pair of CONFIG_EMBEDDED options call
> > CONFIG_BASE_FULL/CONFIG_BASE_SMALL. Disabling CONFIG_BASE_FULL sets
> > the boolean CONFIG_BASE_SMALL to 1 and it is used to shrink a number
> > of core data structures. The space savings for the current batch is
> > around 14k.
> 
> Why _two_ config options?

Um, Andrew made me do it?

One option is an int and is used thusly:

#define FOO (CONFIG_BASE_SMALL ? 1 : 1000)

But it's also sometimes useful to have two opposing options so that
you can use:

obj-(CONFIG_OBJ_A) += a.obj obj-(CONFIG_OBJ_B) += b.obj

-- 
Mathematics is the supreme nostalgia of our time.
