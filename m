Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270094AbTHCU0v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 16:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270218AbTHCU0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 16:26:51 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:59653 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S270094AbTHCU0u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 16:26:50 -0400
Date: Sun, 3 Aug 2003 22:26:41 +0200
From: Willy Tarreau <willy@w.ods.org>
To: bert hubert <ahu@ds9a.nl>, Willy Tarreau <willy@w.ods.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, devik@cdi.cz
Subject: Re: [PATCH] Allow /dev/{,k}mem to be disabled to prevent kernel from being modified easily
Message-ID: <20030803202641.GA1924@alpha.home.local>
References: <20030803180950.GA11575@outpost.ds9a.nl> <20030803191102.GA29616@alpha.home.local> <20030803191833.GA13803@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030803191833.GA13803@outpost.ds9a.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03, 2003 at 09:18:33PM +0200, bert hubert wrote:
 
> Well, I fear the runtime overhead - as it is, I suspect this patch is
> somewhat inflamatory anyhow ('tough luck you were hacked', 'you are fscked
> anyhow').

I don't worry about this on opening *mem !

> I'll whip up a dynamic patch soonish - I'm unsure about the right location,
> /proc/sys/ something?

hmmm something such as /proc/sys/kernel/secured ?

You could even implement 3 levels :
 - 0 = normal
 - 1 = secured, but can go back to 0. At least this stops automated scripts.
 - 2 = secured and cannot go back to lower level anyhow.

Cheers,
Willy
