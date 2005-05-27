Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVE0AMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVE0AMG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 20:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVE0AMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 20:12:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40380 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261706AbVE0AME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 20:12:04 -0400
Date: Thu, 26 May 2005 17:11:56 -0700
Message-Id: <200505270011.j4R0BuwN011311@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Parag Warudkar <kernel-stuff@comcast.net>
X-Fcc: ~/Mail/linus
Cc: Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       mtk-lkml@gmx.net, linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
Subject: Re: waitid() fails with EINVAL for SA_RESTART signals
In-Reply-To: Parag Warudkar's message of  Thursday, 26 May 2005 20:03:28 -0400 <200505262003.29228.kernel-stuff@comcast.net>
Emacs: impress your (remaining) friends and neighbors.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are using the test with an old glibc that doesn't know about the waitid
systme call.  Use strace to see what system calls are actually being made.
