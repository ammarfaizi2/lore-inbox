Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267475AbTGHPcL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 11:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267470AbTGHPcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 11:32:11 -0400
Received: from ev2.cpe.orbis.net ([209.173.192.122]:20874 "EHLO srv.foo21.com")
	by vger.kernel.org with ESMTP id S267473AbTGHPcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 11:32:06 -0400
Date: Tue, 8 Jul 2003 10:46:36 -0500
From: Eric Varsanyi <e0216@foo21.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll vs stdin/stdout
Message-ID: <20030708154636.GM9328@srv.foo21.com>
References: <20030707154823.GA8696@srv.foo21.com> <Pine.LNX.4.55.0307071153270.4704@bigblue.dev.mcafeelabs.com> <20030707194736.GF9328@srv.foo21.com> <Pine.LNX.4.55.0307071511550.4704@bigblue.dev.mcafeelabs.com> <Pine.LNX.4.55.0307071624550.4704@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307071624550.4704@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 07, 2003 at 04:26:21PM -0700, Davide Libenzi wrote:
> On Mon, 7 Jul 2003, Davide Libenzi wrote:
> Try out this one, either over 2.5.74 or over an existing epoll-patched
> 2.4.{20,21} ...

This appears to be working as advertised, thanks! 

IMO it doesn't seem that evil to deliver events per-fd rather than
per-file, this is similar to the semantic you get from select() on
fd's sharing an object. To be surprised someone would have to have
coded to the (previous) sharing visible nature of epoll and be expecting 
the EEXIST back when sharing was in play.

-Eric Varsanyi
