Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262810AbVAKQQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbVAKQQK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 11:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbVAKQQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 11:16:09 -0500
Received: from mail.dif.dk ([193.138.115.101]:34234 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262805AbVAKQPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 11:15:50 -0500
Date: Tue, 11 Jan 2005 17:18:22 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-net <linux-net@vger.kernel.org>, netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] remove unused variables in net/sunrpc/auth.c
In-Reply-To: <20050110221651.GA29578@stusta.de>
Message-ID: <Pine.LNX.4.61.0501111716580.3368@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0501102239000.2987@dragon.hygekrogen.localhost>
 <20050110221651.GA29578@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2005, Adrian Bunk wrote:

> On Mon, Jan 10, 2005 at 10:50:34PM +0100, Jesper Juhl wrote:
> > 
> > We have a few unused variables in net/sunrpc/auth.c:320:
> > 
> > net/sunrpc/auth.c:320: warning: unused variable `auth'
> > net/sunrpc/auth.c:333: warning: unused variable `auth'
> > net/sunrpc/auth.c:345: warning: unused variable `auth'
> > net/sunrpc/auth.c:385: warning: unused variable `auth'
> > 
> > As far as I can see, the patch that caused them to become unused is this 
> > one (which btw is ~36 months old) :
> > http://linux.bkbits.net:8080/linux-2.6/diffs/net/sunrpc/auth.c@1.4?nav=index.html|src/|src/net|src/net/sunrpc|hist/net/sunrpc/auth.c
> > 
> > Here is a patch to get rid of them (compile tested only).
> >...
> 
> Doesn't this break with CONFIG_SYSCTL=y?
> 
Yes, yes it does. I didn't see the CONFIG_SYSCTL connection and thus 
didn't test that :(   
Please disregard the patch, it's wrong.

-- 
Jesper Juhl


