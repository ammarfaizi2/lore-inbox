Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269088AbUIAA2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269088AbUIAA2s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 20:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269083AbUIAA2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 20:28:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:59307 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269088AbUIAA2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 20:28:09 -0400
Date: Tue, 31 Aug 2004 17:27:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>
Subject: Re: [PATCH] cleanup ptrace stops and remove notify_parent
In-Reply-To: <200408312354.i7VNsAND001811@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0408311726560.2295@ppc970.osdl.org>
References: <200408312354.i7VNsAND001811@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Aug 2004, Roland McGrath wrote:
> 
> That's a different implementation than what we've got now.  Feel free to
> try to make it work.  Linus has talked before about treating the state as a
> bitmask, but the code is not actually written that way now.  

The state itself shouldn't be a bitmask, but the _values_ get used for 
masks in quite a few places (ie "task->state & (TASK_DEAD | TASK_ZOMBIE)").

		Linus
