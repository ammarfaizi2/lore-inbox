Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264222AbUEDDtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264222AbUEDDtl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 23:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264223AbUEDDtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 23:49:41 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:62191 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264222AbUEDDti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 23:49:38 -0400
Subject: errno
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton OSDL <akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1083634011.952.154.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 03 May 2004 21:26:52 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> No, there's something wrong. Nobody should use a global
> "errno" variable, and we should fix the real bug (it's
> probably some buggy system call "interface" function
> that is being used).

According to lib/errno.c it's your fault. (SCO code?)

The obvious fix would be to stuff errno into the
task_struct, hmmm? Then just add this:

#define errno (current->kernel_errno)

Otherwise:

#define errno   Do not use this.


