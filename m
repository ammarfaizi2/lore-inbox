Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWABO6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWABO6O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 09:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWABO6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 09:58:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27875 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750768AbWABO6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 09:58:13 -0500
Subject: Re: Kernel Make system and linking static libraries on kernel
	version s2.6.14+
From: Arjan van de Ven <arjan@infradead.org>
To: "Puvvada, Vijay B." <vijay.b.puvvada@saic.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1136213489.3483.18.camel@hadji>
References: <1136213489.3483.18.camel@hadji>
Content-Type: text/plain
Date: Mon, 02 Jan 2006 15:58:09 +0100
Message-Id: <1136213889.2936.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-02 at 09:51 -0500, Puvvada, Vijay B. wrote:
> Hello, 
> 
> This is a "I'm stumped kind of problem" and desperately need some
> guidance with regards to the kernel make system..
> 
> I had also started a thread at 
> http://forums.fedoraforum.org/showthread.php?p=428551#post428551 with
> regards to this, where I describe the context of the problem.  
> 
> In a nutshell, I am trying to compile the Nortel VPN client (which is
> written as part driver and part app) against the 2.6.14 kernel and I am
> getting the following warning. 
> 
> Warning: could not
> find /usr/local/cvc_linux-rh-gcc3-3.3/src/k2.6/../.libmishim-2.6.a.cmd
> for /usr/local/cvc_linux-rh-gcc3-3.3/src/k2.6/../libmishim-2.6.a


it'll be a LOT easier for you to rewrite the Makefile such that you
don't get .a files but a .o file similar to how the rest of kbuild
operates.... while we do use .a files for linking into the vmlinux.. for
modules it's probably not the best of ideas
(and there's not really an advantage do doing so either anyway)

