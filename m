Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316364AbSGVFcc>; Mon, 22 Jul 2002 01:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316322AbSGVFcc>; Mon, 22 Jul 2002 01:32:32 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:61369 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S316342AbSGVFcb>;
	Mon, 22 Jul 2002 01:32:31 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: __set_current_state() suckage...
Date: Mon, 22 Jul 2002 15:35:24 +1000
Message-Id: <20020722053633.7DCD641FE@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Should we rename __set_current_state to set_current_state, and put the
mb() inside add_wait_queue(), add_wait_queue_exclusive() and maybe
add_wait_queue_cond()?

People are getting confused by set_current_state() vs
__set_current_state(), esp. since it's only meaningful for
TASK_INTERRUPTIBLE/UNINTERRUPTIBLE.

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
