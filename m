Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268250AbUIBSUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268250AbUIBSUj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 14:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268277AbUIBSUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 14:20:32 -0400
Received: from holomorphy.com ([207.189.100.168]:28367 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268250AbUIBSUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 14:20:19 -0400
Date: Thu, 2 Sep 2004 11:20:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Kirill Korotaev <kksx@mail.ru>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fixed pidhashing patch
Message-ID: <20040902182014.GG5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Kirill Korotaev <kksx@mail.ru>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <E1C2ppG-0003xU-00.kksx-mail-ru@f16.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1C2ppG-0003xU-00.kksx-mail-ru@f16.mail.ru>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 03:32:22PM +0400, Kirill Korotaev wrote:
> I cleanuped it once again. It compiles/works fine.
> Hope there will be no more problems with it.
> list of small changes:
> - FIXED bug in do_each_task_pid() made by Lee. last task was skipped in the loop, removed __list__ var.
> - remade patch against latest tree (there was a conflict in exit.c)
> - returned 'extern' in find_pid() declaration
> - fixed style a bit in detach_pid(), find_task_by_pid_type()

Heh, looks like I flubbed the loop condition too. For some reason I
thought pid_list was headed at the leader instead of being headerless,
which upon a rereading I see now, so explaining my confusion there.
The semicolon-requiring bits don't appear to be used by any of the
other do { ... } while(...) -style iterators, so I won't press that.

This patch appears sound and stylistically good. Linus, please add:

Signed-off-by: William Irwin <wli@holomorphy.com>


-- wli
