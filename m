Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266294AbUA2Tmh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 14:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266326AbUA2Tmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 14:42:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:26540 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266294AbUA2Tle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 14:41:34 -0500
Date: Thu, 29 Jan 2004 11:41:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Tim Hockin <thockin@sun.com>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       akpm@osld.org.sun.com, rusty@rustcorp.com.au
Subject: Re: PATCH - NGROUPS 2.6.2rc2 + fixups
In-Reply-To: <20040129192556.GM9155@sun.com>
Message-ID: <Pine.LNX.4.58.0401291138390.689@home.osdl.org>
References: <20040129192556.GM9155@sun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Jan 2004, Tim Hockin wrote:
> 
> What think?

I still don't understand the complexity.

Why the list of pages? Is there really any valid use for this that could 
overflow a simple "kmalloc()"? How many groups do people really really 
need? 

I just find it wrong to go from 32 to millions. And a few thousand can
trivially be handled by a normal "kmalloc()".

Basically, I find overdesign physically nauseating. This is less so than 
the original stuff, but I'm still finding myself asking "Why?".

		Linus
