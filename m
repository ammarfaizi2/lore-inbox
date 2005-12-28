Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbVL1NRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbVL1NRw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 08:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbVL1NRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 08:17:52 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:24629 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S964807AbVL1NRv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 08:17:51 -0500
Date: Wed, 28 Dec 2005 13:47:04 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 02/2] allow gcc4 to optimize unit-at-a-time
Message-ID: <20051228124704.GA9503@mars.ravnborg.org>
References: <20051228114701.GC3003@elte.hu> <20051228120435.GS22293@devserv.devel.redhat.com> <20051228122815.GA9365@mars.ravnborg.org> <20051228130435.GU22293@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051228130435.GU22293@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 08:04:35AM -0500, Jakub Jelinek wrote:
> No.
> -fno-unit-at-a-time should be used with GCCs that
> a) support it
> b) are older than GCC 4.0
> 
> The "$(GCC_VERSION) -lt 0400" test cares of b),
> $(call cc-option,-fno-unit-at-a-time) cares of a).

There was a reason for disabling it unconditionally in first place.
That was due to unexpected huge stack usage if I understand correct.
Ingo's patch enebles unit-at-a-time only for gcc > 4.00 which should
have this issue fixed.

If the argument is that we suddenly shall enable unit-at-a-time for
gcc before 4.00 then we should visit the reasons why it originally was
disabled.

	Sam
