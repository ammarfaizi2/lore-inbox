Return-Path: <linux-kernel-owner+w=401wt.eu-S1754998AbWL1VSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754998AbWL1VSP (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 16:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755002AbWL1VSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 16:18:14 -0500
Received: from [139.30.44.16] ([139.30.44.16]:22265 "EHLO
	gockel.physik3.uni-rostock.de" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754999AbWL1VSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 16:18:13 -0500
Date: Thu, 28 Dec 2006 22:18:12 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove 556 unneeded #includes of sched.h
In-Reply-To: <20061228210803.GR17561@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.63.0612282211330.20531@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.63.0612282059160.8356@gockel.physik3.uni-rostock.de>
 <20061228124644.4e1ed32b.akpm@osdl.org> <Pine.LNX.4.63.0612282154460.20531@gockel.physik3.uni-rostock.de>
 <20061228210803.GR17561@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006, Al Viro wrote:

> Uh-huh.  How much of build coverage have you got with it?

Well, as said in the patch description, I compiled alpha, arm, i386, ia64, 
mips, powerpc, and x86_64 with allnoconfig, defconfig, allmodconfig, and 
allyesconfig as well as a few randconfigs on x86_64. I also checked that 
no new warnings were introduced by the patch.

> Note that "doesn't use symbols defined in sched.h" != "can remove 
> include of sched.h", which, in turn, is not the same as "removing it 
> doesn't cause problems on a couple of configs I've tried on amd64".

Sure. But from my experience (I started posting these patches almost five 
years ago, inspired by a blog entry by davej) actually the only thing that 
prevents removing the sched.h include (other than using symbols defined 
there) is dereferencing current, which my scripts also check.

Tim
