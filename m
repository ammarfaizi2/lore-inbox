Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbTEKStm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 14:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbTEKStm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 14:49:42 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57359 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261156AbTEKSth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 14:49:37 -0400
Date: Sun, 11 May 2003 12:01:49 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: mikpe@csd.uu.se, Pavel Machek <pavel@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore sysenter MSRs at resume
In-Reply-To: <200305101641.h4AGfEVE002970@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.44.0305111158500.12955-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 10 May 2003 mikpe@csd.uu.se wrote:
> 
> This patch should be better. It changes apm.c to invoke
> suspend.c's save and restore processor state procedures
> around suspends, which fixes the SYSENTER MSR problem.

Applied.

However, the fact that the SYSENTER MSR needs to be restored makes me
suspect that the other MSR/MTRR also will need restoring. I don't see 
where we'd be doing that, but it sounds to me like it should be done here 
too..

		Linus

