Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUIEAZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUIEAZu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 20:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbUIEAZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 20:25:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:8592 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265044AbUIEAZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 20:25:48 -0400
Date: Sat, 4 Sep 2004 17:23:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: joern@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] copyfile: generic_sendpage
Message-Id: <20040904172349.7e39da22.akpm@osdl.org>
In-Reply-To: <20040905001653.GA3106@holomorphy.com>
References: <20040904165733.GC8579@wohnheim.fh-wedel.de>
	<20040904153902.6ac075ea.akpm@osdl.org>
	<20040905001653.GA3106@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Sat, Sep 04, 2004 at 03:39:02PM -0700, Andrew Morton wrote:
> > I don't know how much of a problem this is in practice - there are all
> > sorts of nasty things which unprivileged apps can do to the system by
> > overloading filesystems.  Although most of them can be killed off by the
> > sysadmin.
> > (My infamous bash-shared-mappings stresstest can spend ten or more minutes
> > within a single write() call, but you have to try hard to do this).
> 
> This reminds me; I'm having a chicken and egg problem with several
> stresstests I've written but withheld until fixes for the crashes they
> trigger are available, but the fixes appear to be hard enough to arrange
> they need public commentary to find acceptable methods of addressing
> them. What's the recommended procedure for all this?
> 

A local DoS via resource exhaustion would not be an earth-shatteringly new
development.  Just send 'em out.
