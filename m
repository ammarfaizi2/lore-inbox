Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264389AbUEIVDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUEIVDm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 17:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264393AbUEIVDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 17:03:42 -0400
Received: from waste.org ([209.173.204.2]:60129 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264389AbUEIVDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 17:03:41 -0400
Date: Sun, 9 May 2004 16:03:12 -0500
From: Matt Mackall <mpm@selenic.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, akpm@osdl.org, dipankar@in.ibm.com,
       manfred@colorfullife.com, davej@redhat.com, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, maneesh@in.ibm.com,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: dentry bloat.
Message-ID: <20040509210312.GL5414@waste.org>
References: <20040508120148.1be96d66.akpm@osdl.org> <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org> <Pine.LNX.4.58.0405081216510.3271@ppc970.osdl.org> <20040508204239.GB6383@in.ibm.com> <20040508135512.15f2bfec.akpm@osdl.org> <20040508211920.GD4007@in.ibm.com> <20040508171027.6e469f70.akpm@osdl.org> <Pine.LNX.4.58.0405081947290.1592@ppc970.osdl.org> <20040508201215.24f0d239.davem@redhat.com> <Pine.LNX.4.58.0405082039510.1592@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405082039510.1592@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One also wonders about whether all the RCU stuff is needed on UP. I'm
not sure if I grok all the finepoints here, but it looks like the
answer is no and that we can make struct_rcu head empty and have
call_rcu fall directly through to the callback. This would save
something like 16-32 bytes (32/64bit), not to mention a bunch of
dinking around with lists and whatnot.

So what am I missing?

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
