Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030365AbWILTZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbWILTZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 15:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbWILTZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 15:25:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27053 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030365AbWILTZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 15:25:25 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060912174339.GA19707@waste.org> 
References: <20060912174339.GA19707@waste.org>  <6d6a94c50609032356t47950e40lbf77f15136e67bc5@mail.gmail.com> <17162.1157365295@warthog.cambridge.redhat.com> <6d6a94c50609042052n4c1803eey4f4412f6153c4a2b@mail.gmail.com> <3551.1157448903@warthog.cambridge.redhat.com> <6d6a94c50609051935m607f976j942263dd1ac9c4fb@mail.gmail.com> <44FE4222.3080106@yahoo.com.au> <6d6a94c50609120107w1942a8d8j368dd57a271d0250@mail.gmail.com> 
To: Matt Mackall <mpm@selenic.com>
Cc: Aubrey <aubreylee@gmail.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       davidm@snapgear.com, gerg@snapgear.com
Subject: Re: kernel BUGs when removing largish files with the SLOB allocator 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 12 Sep 2006 20:25:04 +0100
Message-ID: <24525.1158089104@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:

> Looking through all the users of kobjsize, it seems we always know
> what the type is (and it's usually a VMA). I instead propose we use
> ksize on objects we know to be SLAB/SLOB-allocated and add a new
> function (kpagesize?) to size other objects where nommu needs it.

It sounds like we'd need an op in the VMA to do the per-type size thing (the
VMA itself not the VMA ops table).

David
