Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030410AbVJEWsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbVJEWsi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 18:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbVJEWsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 18:48:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54453 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030410AbVJEWsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 18:48:37 -0400
Date: Wed, 5 Oct 2005 15:48:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Junio C Hamano <junkio@cox.net>
cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: clone: I'm only doing a max of 256 requests
In-Reply-To: <7vy857iqzh.fsf@assigned-by-dhcp.cox.net>
Message-ID: <Pine.LNX.4.64.0510051547090.31407@g5.osdl.org>
References: <20051005191300.GC17475@hexapodia.org> <7virwbu4wz.fsf@assigned-by-dhcp.cox.net>
 <7vhdbvk6ln.fsf@assigned-by-dhcp.cox.net> <7vy857iqzh.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Oct 2005, Junio C Hamano wrote:
> 
> Hmph.  I was reading linux-2.6/fs/exec.c::copy_strings(), but I
> do not see any such size limit (other than exceeding the total
> machine memory size, probably reported by alloc_page() failing)
> imposed there.  Am I looking at the wrong place?

Look for "MAX_ARG_PAGES".

Ie the limit is about 128kB by default (32 pages). Note that that includes 
not just arguments, but environment.

		Linus
