Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268360AbUHQT7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268360AbUHQT7g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 15:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268396AbUHQT7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 15:59:36 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:21889 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S268360AbUHQT7e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 15:59:34 -0400
Date: Tue, 17 Aug 2004 23:59:42 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: ldchk -> arch/arm/Makefile? [Was: 2.6.8.1-mm1]
Message-ID: <20040817215941.GA23582@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20040816143710.1cd0bd2c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040816143710.1cd0bd2c.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew.

The following two patches can be dropped from -mm. The functionality has
moved to scripts/mksysmap


handle-undefined-symbols.patch
  Fail if vmlinux contains undefined symbols
  
sparc32-ignore-undefined-symbols-with-3-or-more-leading-underscores.patch
  sparc32: ignore undefined symbols with 3 or more leading underscores
    

On the topic of undefined symbols only certain ARM tool-chains
actually have this problem.
Russell - would it be possible to move the check to arch/arm/Makefile?
Assuming people always build zImage or one of the other arch specific targets.

This check have so far caused much more pain than it ought to do - so
if we could move it to where it really matters would be better.

	Sam
