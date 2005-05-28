Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262669AbVE1CTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbVE1CTk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 22:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbVE1CTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 22:19:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:28358 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262669AbVE1CTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 22:19:33 -0400
Date: Fri, 27 May 2005 19:21:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: perex@suse.cz, linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: ALSA official git repository
In-Reply-To: <20050527154625.5490f405.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0505271854300.17402@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
 <Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
 <Pine.LNX.4.58.0505271941250.1757@pnote.perex-int.cz>
 <Pine.LNX.4.58.0505271113410.17402@ppc970.osdl.org> <20050527135124.0d98c33e.akpm@osdl.org>
 <Pine.LNX.4.58.0505271502240.17402@ppc970.osdl.org> <20050527154625.5490f405.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 May 2005, Andrew Morton wrote:
> 
> That all assumes that the tools are smart enough to separate the email
> headers from the body :(

Well, _that_ is trivial: the first empty line is the marker between header 
and body. 

This is a stupid awk program to do this:

	/^From: / { name=$0 }
	state==1 { print name; exit }
	/^$/ { state=1 }

Or something. 


		Linus
