Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263140AbUCMRlh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 12:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263141AbUCMRlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 12:41:37 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:39073 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263140AbUCMRlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 12:41:36 -0500
Date: Sat, 13 Mar 2004 17:41:37 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Rik van Riel <riel@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: anon_vma RFC2
In-Reply-To: <Pine.LNX.4.44.0403131227210.15971-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0403131739270.3628-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Mar 2004, Rik van Riel wrote:
> 
> No, Linus is right.
> 
> If a child process uses mremap(), it stands to reason that
> it's about to use those pages for something.
> 
> Think of it as taking the COW faults early, because chances
> are you'd be taking them anyway, just a little bit later...

Makes perfect sense in the read-write case.  The read-only
case is less satisfactory, but those will be even rarer.

Hugh

