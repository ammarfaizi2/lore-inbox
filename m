Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbTLWAs4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 19:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbTLWAs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 19:48:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:21386 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264923AbTLWAsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 19:48:55 -0500
Date: Mon, 22 Dec 2003 16:49:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: corbet@lwn.net (Jonathan Corbet)
Cc: anton@samba.org, mh@nadir.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seq_file version of /proc/interrupts
Message-Id: <20031222164946.61644783.akpm@osdl.org>
In-Reply-To: <20031223003831.25486.qmail@lwn.net>
References: <20031223002217.GC934@krispykreme>
	<20031223003831.25486.qmail@lwn.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

corbet@lwn.net (Jonathan Corbet) wrote:
>
> > -	int i, j;
> > +	int i = *(int *) v, j;
> 
> > That int * has to be a loff_t * or bad things will happen on a 64bit big
> > endian platform :)
> 
> You mean the world's not all an x86?  What are things coming to?
> 
> Andrew, Marc, this seems almost certain to the the source of the problem
> you brought to my attention.  I'll try to get a supplemental patch to you
> tomorrow.  Obviously, it should be a loff_t for all architectures, even if
> it works for most now.

hmm, I seem to have already fixed pppc64.  I'll fix up the other
architectures.

