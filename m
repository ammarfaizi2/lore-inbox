Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263685AbUCUSOv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 13:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263686AbUCUSOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 13:14:51 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:16514 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263685AbUCUSOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 13:14:49 -0500
Date: Sun, 21 Mar 2004 19:14:30 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040321181430.GB29440@wohnheim.fh-wedel.de>
References: <20040321125730.GB21844@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0403210944310.12359-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0403210944310.12359-100000@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 March 2004 09:59:39 -0800, Davide Libenzi wrote:
> 
> When I did that, fumes of an in-kernel implementation invaded my head for 
> a little while. Then you start thinking that you have to teach apps of new 
> open(2) semantics, you have to bloat kernel code a little bit and you have 
> to deal with a new set of errors cases that open(2) is not expected to 
> deal with. A fully userspace implementation did fit my needs at that time, 
> even if the LD_PRELOAD trick might break if weak aliases setup for open 
> functions change inside glibc.

209 fairly simple lines definitely have more appear than a full
in-kernel implementation with many new corner-cases, yes.  But it
looks as if you ignore the -ENOSPC case, so you cheated a little. ;)

No matter how you try, there is no way around an additional return
code for open(), so we have to break compatibility anyway.  The good
news is that a) people not using this feature won't notice and b) all
programs I tried so far can deal with the problem.  Vim even has a
decent error message - as if my patch was anticipated already.

Jörn

-- 
Everything should be made as simple as possible, but not simpler.
-- Albert Einstein
