Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264562AbTLMLll (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 06:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264563AbTLMLll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 06:41:41 -0500
Received: from purplechoc.demon.co.uk ([80.176.224.106]:8064 "EHLO
	skeleton-jack.localnet") by vger.kernel.org with ESMTP
	id S264562AbTLMLlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 06:41:40 -0500
Date: Sat, 13 Dec 2003 11:41:34 +0000
To: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Subject: Possible shared mapping bug in 2.4.23 (at least MIPS/Sparc)
Message-ID: <20031213114134.GA9896@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Horton <pdh@colonel-panic.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current MIPS 2.4 kernel (from CVS) currently allows fixed shared
mappings to violate D-cache aliasing constraints.

The check for illegal fixed mappings is done in
arch_get_unmapped_area(), but these mappings are granted in
get_unmapped_area() and arch_get_unmapped_area() is never called.

A quick look at sparc and sparc64 seem to show the same problem.

P.
