Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVBSBLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVBSBLn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 20:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVBSBLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 20:11:43 -0500
Received: from fire.osdl.org ([65.172.181.4]:48002 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261600AbVBSBLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 20:11:41 -0500
Date: Fri, 18 Feb 2005 17:16:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jay Lan <jlan@sgi.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       guillaume.thouvenin@bull.net, tim@physik3.uni-rostock.de
Subject: Re: A common layer for Accounting packages
Message-Id: <20050218171610.757ba9c9.akpm@osdl.org>
In-Reply-To: <42168D9E.1010900@sgi.com>
References: <42168D9E.1010900@sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan <jlan@sgi.com> wrote:
>
> Since the need of Linux system accounting has gone beyond what BSD
> accounting provides, i think it is a good idea to create a thin layer
> of common code for various accounting packages, such as BSD accounting,
> CSA, ELSA, etc. The hook to do_exit() at exit.c was changed to invoke
> a routine in the common code which would then invoke those accounting
> packages that register to the acct_common to handle do_exit situation.

This all seems to be heading in the wrong direction.  Do we really want to
have lots of different system accounting packages all hooking into a
generic we-cant-decide-what-to-do-so-we-added-some-pointless-overhead
framework?

Can't we get _one_ accounting system in there, get it right, avoid the
framework?
