Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUCTVFP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 16:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263543AbUCTVFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 16:05:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:22968 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263540AbUCTVFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 16:05:08 -0500
Date: Sat, 20 Mar 2004 13:05:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Armin Schindler <armin@melware.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 2.6] serialization of kernelcapi work
Message-Id: <20040320130509.660c350e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.31.0403202048010.27103-100000@phoenix.one.melware.de>
References: <20040320111431.4ba002f1.akpm@osdl.org>
	<Pine.LNX.4.31.0403202048010.27103-100000@phoenix.one.melware.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Armin Schindler <armin@melware.de> wrote:
>
> > However you are limiting things so only a single CPU can run `work to do'
>  > at any time, same as with a semaphore.
> 
>  Well, limiting the 'work to do' to one CPU is exactly what I need to do,
>  the code must not run on another CPU at the same time.

Across the entire kernel?  For *all* ISDN connections and interfaces?

Surely there must be some finer-grained level at which the serialisation is
needed - per-inteface, per-connection, per-session, whatever?

