Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264596AbUD1CDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264596AbUD1CDo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 22:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264600AbUD1CDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 22:03:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65454 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264596AbUD1CDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 22:03:42 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16527.4259.174536.629347@segfault.boston.redhat.com>
Date: Tue, 27 Apr 2004 22:02:11 -0400
To: Carson Gaspar <carson@taltos.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: kernel BUG at page_alloc.c:98 -- compiling with distcc
In-Reply-To: <382320000.1082759593@taltos.ny.ficc.gs.com>
References: <382320000.1082759593@taltos.ny.ficc.gs.com>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>FYI, we see the exact same panic with the tg3 driver using 2.4.25 and 
>distcc with sendfile(). The bcm5700 driver also panics, but I haven't 
>captured a panic message to be certain it's the same bug.

>kernel BUG at page_alloc.c:98!

Andrea fixed this in his tree by deferring the page free to process context
instead of BUG()ing on PageLRU(page).

-Jeff
