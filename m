Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265221AbUBAFnG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 00:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbUBAFnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 00:43:06 -0500
Received: from mail2.speakeasy.net ([216.254.0.202]:28056 "EHLO
	mail2.speakeasy.net") by vger.kernel.org with ESMTP id S265221AbUBAFm6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 00:42:58 -0500
Date: Sat, 31 Jan 2004 21:42:52 -0800
Message-Id: <200402010542.i115gqbM026295@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Daniel Jacobowitz <dan@debian.org>
X-Fcc: ~/Mail/linus
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: More waitpid issues with CLONE_DETACHED/CLONE_THREAD
In-Reply-To: Daniel Jacobowitz's message of  Sunday, 1 February 2004 00:14:35 -0500 <20040201051435.GA19421@nevyn.them.org>
Emacs: it's all fun and games, until somebody tries to edit a file.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I thought that a new group leader would be swapped in to that TID?  But
> I was always confused by the mechanics of that.

The group leader never changes.  The zombie group leader just sticks around
until there are no other threads in the group.  (The only exception here is
exec.)
