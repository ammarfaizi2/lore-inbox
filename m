Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVEaObI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVEaObI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 10:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVEaObI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 10:31:08 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:60743
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261680AbVEaObB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 10:31:01 -0400
Date: Tue, 31 May 2005 16:30:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: James Bruce <bruce@andrew.cmu.edu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, "Bill Huey (hui)" <bhuey@lnxw.com>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050531143051.GL5413@g5.random>
References: <4299A98D.1080805@andrew.cmu.edu> <429ADEDD.4020805@yahoo.com.au> <429B1898.8040805@andrew.cmu.edu> <429B2160.7010005@yahoo.com.au> <20050530222747.GB9972@nietzsche.lynx.com> <429BBC2D.70406@yahoo.com.au> <20050531020957.GA10814@nietzsche.lynx.com> <429C2A64.1040204@andrew.cmu.edu> <429C2F72.7060300@yahoo.com.au> <429C4112.2010808@andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429C4112.2010808@andrew.cmu.edu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 06:48:50AM -0400, James Bruce wrote:
> orthogonal, because *if* preempt-RT patch becomes guaranteed hard-RT, it 

I don't see how can preempt-RT ever become hard-RT when a simple lock
hangs it. As soon as you call kernel code, you'll eventually hang,
kmalloc will have to allocate memory and pageout other stuff no matter
what.

I really hope embedded developers knows better and they don't get the
idea of using preempt-RT where hard-RT is required.
