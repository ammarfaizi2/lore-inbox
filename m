Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263503AbSIQCli>; Mon, 16 Sep 2002 22:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263509AbSIQCli>; Mon, 16 Sep 2002 22:41:38 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:7825 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S263503AbSIQCli>; Mon, 16 Sep 2002 22:41:38 -0400
Date: Tue, 17 Sep 2002 03:46:25 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Question about CLONE_CLEARTID and thread group leader
Message-ID: <20020917034625.A22892@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Ingo,

CLONE_CLEARTID was created so that a thread can notify its partner
threads that its stack may by freed or reused.  It is needed because the
stack isn't free until the exit() system call begins.

One question has been bothering me for a while: what about the thread
group leader's stack?  These days, isn't it the case that the group
leader is supposed to be equivalent to the other threads?  If so, how
does it exit and release its own stack -- or do we understand that the
group leader, as a one-off exception, has to block signals before exiting?

Thanks,
-- Jamie
