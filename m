Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263881AbUGRMm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263881AbUGRMm6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 08:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUGRMm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 08:42:58 -0400
Received: from colossus.systems.pipex.net ([62.241.160.73]:6868 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id S263881AbUGRMm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 08:42:56 -0400
Date: Sun, 18 Jul 2004 13:41:34 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@einstein.homenet
To: Solar Designer <solar@openwall.com>
Cc: Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: question about /proc/<PID>/mem in 2.4 (fwd)
In-Reply-To: <20040707234852.GA8297@openwall.com>
Message-ID: <Pine.LNX.4.44.0407181336040.2374-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for your reply, but this one bit still remains utterly unclear 
to me:

> Alan has already pointed out a reason why the MAY_PTRACE()
> check was needed:
> 
> | Consider what happens if your setuid app reads stdin
> | 
> | 	setuidapp < /proc/self/mem
> 
> ... 
> See Alan's example I've quoted above.  In this scenario, it would be
> the program being attacked which will be checked for possession of the
> capability... if it is SUID root, the attack will succeed.

In the above example there is nothing forbidden and the current state of 
things doesn't prevent the program from reading it's own address space.

Thus I see absolutely nothing special about the case:

# setuidapp < /proc/self/mem

and this program reading stdin. Maybe I am missing something obvious but I
have 10+ years of Unix systems programming experience and having consulted
some people who have 20+ years of such experience they are also of the
same opinion, i.e. nothing special in the above case.

Could you therefore clarify it, please? Thank you in advance!

Kind regards
Tigran

