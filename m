Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVBZDl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVBZDl1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 22:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVBZDlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 22:41:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:3046 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261406AbVBZDlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 22:41:07 -0500
Date: Fri, 25 Feb 2005 19:42:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: nuclearcat <nuclearcat@nuclearcat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: pty_chars_in_buffer NULL pointer (kernel oops)
In-Reply-To: <20050225230432.GD15251@logos.cnet>
Message-ID: <Pine.LNX.4.58.0502251935420.9237@ppc970.osdl.org>
References: <1567604259.20050218105653@nuclearcat.com> <20050225230432.GD15251@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 Feb 2005, Marcelo Tosatti wrote:
> 
> BTW, I fail to see any drivers/char/pty.c change related to the race which triggers
> the pty_chars_in_buffer->0 oops.

Indeed, I don't think 2.6.x got that merged, because it was never really 
clear _which_ fix was the right one (the extra locking was absolutely 
deadly for performance, the hacky one was a tad _too_ hacky ;)

Alan, did you ever decide what the proper locking would be? I've applied
the hacky "works by hiding the problem" patch for 2.6.11 which didn't have 
any subtle performance issues associated with it.

		Linus
