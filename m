Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267446AbUHSWC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267446AbUHSWC2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 18:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267451AbUHSWC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 18:02:27 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:50449 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S267446AbUHSWCS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 18:02:18 -0400
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] notify_parent cleanup
References: <200408192059.i7JKxh4F024918@magilla.sf.frob.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 20 Aug 2004 07:01:58 +0900
In-Reply-To: <200408192059.i7JKxh4F024918@magilla.sf.frob.com>
Message-ID: <87y8kazt0p.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> writes:

> > Roland McGrath <roland@redhat.com> writes:
> > > +	BUG_ON(tsk->state != TASK_STOPPED);
> > 
> > task->state is changed anytime, right?  Although the window is small,
> > I think we should remove it at least for right now.

> I put it there intending just to ensure that all the code paths
> were the stopping ones, as all the extant ones are.

Ah, I see.

Instead of BUG_ON(), how about WARN_ON() for debug? Since window is
small...
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
