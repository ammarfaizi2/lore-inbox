Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVEaLOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVEaLOs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 07:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVEaLOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 07:14:48 -0400
Received: from colin.muc.de ([193.149.48.1]:13317 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261854AbVEaLOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 07:14:47 -0400
Date: 31 May 2005 13:14:45 +0200
Date: Tue, 31 May 2005 13:14:45 +0200
From: Andi Kleen <ak@muc.de>
To: James Bruce <bruce@andrew.cmu.edu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050531111445.GA35122@muc.de>
References: <4299A98D.1080805@andrew.cmu.edu> <429ADEDD.4020805@yahoo.com.au> <429B1898.8040805@andrew.cmu.edu> <429B2160.7010005@yahoo.com.au> <20050530222747.GB9972@nietzsche.lynx.com> <429BBC2D.70406@yahoo.com.au> <20050531020957.GA10814@nietzsche.lynx.com> <429C2A64.1040204@andrew.cmu.edu> <429C2F72.7060300@yahoo.com.au> <429C4112.2010808@andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429C4112.2010808@andrew.cmu.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 06:48:50AM -0400, James Bruce wrote:
> P.S. Preempt-RT is a sight to behold while updatedb is running.  The 
> difference between it and ordinary preempt is quite impressive.  Nothing 
> currently running has so much as a hiccup, even though / is using the 
> non-latency-friendly ReiserFS.  The only way I even notice updatedb is 
> running at all is through my CPU monitor and the fact that disk IO is 
> slower.

Are you sure it is not only disk IO? In theory updatedb shouldn't 
need much CPU, but it eats a lot of memory and causes stalls 
in the disk (or at least that was my interpration on the stalls I saw)
If there is really a scheduling latency problem with updatedb
then that definitely needs to be fixed in the stock kernel.

-Andi
