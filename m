Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbUBRDrL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 22:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbUBRDrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 22:47:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:64643 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262228AbUBRDrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 22:47:09 -0500
Date: Tue, 17 Feb 2004 19:47:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com
Subject: Re: 2.6.3rc4 ali1535 i2c driver rmmod oops.
In-Reply-To: <20040218031544.GB26304@redhat.com>
Message-ID: <Pine.LNX.4.58.0402171941580.2686@home.osdl.org>
References: <20040218031544.GB26304@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Feb 2004, Dave Jones wrote:
>
> Erk, whats going on here ?

Normally this would mean that somebody is trying to "kfree" a pointer that 
wasn't allocated with "kmalloc()". That seems unlikely in this case, so it 
might be a double free or some other internal corruption..

That "sys_delete_module()" thing seems like some stale kernel stack 
contents, so it's possible that that is the thing that messed up and left 
something in an inconsistent state.

Do you know what module it was?

			Linus
