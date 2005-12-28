Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbVL1NVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbVL1NVT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 08:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbVL1NVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 08:21:19 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:51980 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S964810AbVL1NVS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 08:21:18 -0500
Date: Wed, 28 Dec 2005 13:50:42 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 02/2] allow gcc4 to optimize unit-at-a-time
Message-ID: <20051228125042.GB9503@mars.ravnborg.org>
References: <20051228114701.GC3003@elte.hu> <20051228120435.GS22293@devserv.devel.redhat.com> <20051228122815.GA9365@mars.ravnborg.org> <20051228130435.GU22293@devserv.devel.redhat.com> <20051228124704.GA9503@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051228124704.GA9503@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 01:47:04PM +0100, Sam Ravnborg wrote:
> On Wed, Dec 28, 2005 at 08:04:35AM -0500, Jakub Jelinek wrote:
> > No.
> > -fno-unit-at-a-time should be used with GCCs that
> > a) support it
> > b) are older than GCC 4.0
> > 
> > The "$(GCC_VERSION) -lt 0400" test cares of b),
> > $(call cc-option,-fno-unit-at-a-time) cares of a).
> 
> There was a reason for disabling it unconditionally in first place.
> That was due to unexpected huge stack usage if I understand correct.
> Ingo's patch enebles unit-at-a-time only for gcc > 4.00 which should
> have this issue fixed.
> 
> If the argument is that we suddenly shall enable unit-at-a-time for
> gcc before 4.00 then we should visit the reasons why it originally was
> disabled.
Hi Jakub.

Reading your mail once more I understood it.
And you are right of course.

	Sam - on his way to get more coffee...
