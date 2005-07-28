Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVG1PhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVG1PhA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 11:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVG1Pek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 11:34:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56498 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261484AbVG1Pcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 11:32:36 -0400
Date: Thu, 28 Jul 2005 08:31:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Daniel Walker <dwalker@mvista.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] speed up on find_first_bit for i386 (let compiler do
 the work)
In-Reply-To: <1122554706.29823.228.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0507280830430.3227@g5.osdl.org>
References: <1122473595.29823.60.camel@localhost.localdomain> 
 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net> 
 <1122513928.29823.150.camel@localhost.localdomain> 
 <1122519999.29823.165.camel@localhost.localdomain> 
 <1122521538.29823.177.camel@localhost.localdomain> 
 <1122522328.29823.186.camel@localhost.localdomain>  <42E8564B.9070407@yahoo.com.au>
  <1122551014.29823.205.camel@localhost.localdomain>
 <1122554706.29823.228.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Jul 2005, Steven Rostedt wrote:
>
> The 32 looks like it may be problamatic.  Is there any i386 64 bit
> machines.  Or is hard coding 32 OK?

We have BITS_PER_LONG exactly for this usage, but the sizeof also works. 

		Linus
