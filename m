Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318172AbSGQA11>; Tue, 16 Jul 2002 20:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318174AbSGQA10>; Tue, 16 Jul 2002 20:27:26 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:30196 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318172AbSGQA1Z>; Tue, 16 Jul 2002 20:27:25 -0400
Subject: Re: [PATCH for 2.4] fix find to not stumble over BK
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Larry McVoy <lm@bitmover.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <20020716170821.A8462@work.bitmover.com>
References: <20020716170821.A8462@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 17 Jul 2002 02:40:33 +0100
Message-Id: <1026870033.1688.116.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-17 at 01:08, Larry McVoy wrote:

> Note that common usage
> 
> 	find . -name '*.[chS]' | whatever
> 
> becomes
> 
> 	find . -name SCCS -prune -o -name BitKeeper -prune -o \
> 		-name '*.[chS]' -print | whatever
> 		                ^^^^^^
> 
> The -print is needed or find will produce nothing, it's now multiple clauses.

The -print is not needed. See IEEE Std 1003.1-2001

If no expression is present, -print shall be used as the expression.
Otherwise, if the given expression does not contain any of the primaries
-exec, -ok, or -print, the given expression shall be effectively
replaced by:

( given_expression ) -print

Alan the pedantic

