Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWARHst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWARHst (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 02:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWARHss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 02:48:48 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:5518 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932317AbWARHss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 02:48:48 -0500
Subject: Re: [PATCH] pepoll_wait ...
From: David Woodhouse <dwmw2@infradead.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Andrew Morton <akpm@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.63.0601172338530.4942@localhost.localdomain>
References: <Pine.LNX.4.63.0601171933400.15529@localhost.localdomain>
	 <43CDC21C.7050608@redhat.com> <20060117210318.1f4212f0.akpm@osdl.org>
	 <Pine.LNX.4.63.0601172338530.4942@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 18:48:48 +1100
Message-Id: <1137570528.30084.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-17 at 23:40 -0800, Davide Libenzi wrote:
> Hey, I've written in the comments that it depends on the 
> TIF_RESTORE_SIGMASK bits ;) The latest one that dwmw posted used such 
> feature, so I though to align epoll bits to that too.

The point is that TIF_RESTORE_SIGMASK needs to be implemented for each
architecture, and we only have it for powerpc, i386 and FR-V at the
moment. So in _generic_ files you have to use #ifdef TIF_RESTORE_SIGMASK
for now, until the other architectures catch up.

-- 
dwmw2

