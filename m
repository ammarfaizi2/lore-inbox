Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268593AbUI2P1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268593AbUI2P1y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 11:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268535AbUI2P1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 11:27:47 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:12938 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268662AbUI2P1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 11:27:21 -0400
Subject: Re: heap-stack-gap for 2.6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040929141151.GJ4084@dualathlon.random>
References: <20040925162252.GN3309@dualathlon.random>
	 <1096272553.6572.3.camel@laptop.fenrus.com>
	 <20040927130919.GE28865@dualathlon.random>
	 <20040928194351.GC5037@devserv.devel.redhat.com>
	 <20040928221933.GG4084@dualathlon.random>
	 <20040929060521.GA6975@devserv.devel.redhat.com>
	 <20040929141151.GJ4084@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096467886.15905.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 29 Sep 2004 15:24:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-29 at 15:11, Andrea Arcangeli wrote:
> > MAP_FIXED is to be used only on things YOU mmaped before. 
> 
> where is that written?

MAP_FIXED is for very very special cases only. You can't combine
MAP_FIXED with glibc for example because the memory allocators may clash
with it. You can use it to map over an existing object but that is about
it.

As the man page says

"Use of this option is discouraged."


