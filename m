Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751660AbWAKQVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbWAKQVn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 11:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbWAKQVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 11:21:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49091 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751584AbWAKQVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 11:21:41 -0500
Subject: Re: mm/rmap.c negative page map count BUG.
From: Arjan van de Ven <arjan@infradead.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Octavio Alvarez Piza <alvarezp@alvarezp.ods.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0601111603520.4337@goblin.wat.veritas.com>
References: <20060103082609.GB11738@redhat.com>
	 <43BA630F.1020805@yahoo.com.au> <20060103135312.GB18060@redhat.com>
	 <20060104155326.351a9c01.akpm@osdl.org> <20060105074718.GF20809@redhat.com>
	 <1136448712.2920.4.camel@laptopd505.fenrus.org>
	 <20060105111520.GL20809@redhat.com> <op.s2w4pyqm4oyyg1@octavio.tecbc.mx>
	 <20060111000111.5fa4bdce@octavio.alvarezp.pri>
	 <Pine.LNX.4.61.0601111603520.4337@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 17:21:24 +0100
Message-Id: <1136996484.2929.61.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> That means page->_mapcount contained 0xfffeffff when it should have

> We can't rule out that something somewhere in the kernel has
> scribbled on that location, but I've no guesses what.

could be an rwsem/rwlock



btw.. which video driver is in use? (X tends to do rather evil things at
times via /dev/mem, but that is very much driver specific)

