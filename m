Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUJOWFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUJOWFe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 18:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUJOWFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 18:05:34 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:44037 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261451AbUJOWFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 18:05:08 -0400
Date: Fri, 15 Oct 2004 23:04:45 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrea Arcangeli <andrea@novell.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: per-process shared information
In-Reply-To: <20041015214026.GR5607@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0410152255290.7849-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2004, William Lee Irwin III wrote:
> On Fri, Oct 15, 2004 at 11:28:31PM +0200, Andrea Arcangeli wrote:
> > Ok fine. But first it has to be included into mainline, then of course
> > we'll merge it. Fixing Oracle at the expense of being incompatible with
> > the user-ABI with future 2.6 is a no-way.
> 
> The thing I wanted to convey most was that I got an acknowledgment from
> the original sources of Oracle's requirement, including the project
> lead for the team that maintains statistics collection kit that uses
> the statistics to estimate the client capacity of a system and not just
> whoever got the bug assigned to them inside Oracle, that Hugh's specific
> implementation we want to go with also satisfies the user requirements.
> They've even committed to runtime testing the patches to verify the
> patch does everything they want it to.

Andrea, Bill, great, thanks a lot for doing all the fieldwork on this.

After going through the discussions, I'm inclined to stick with the
patch as is i.e. "correct the 2.6 bug" in the "shared" third field of
/proc/pid/statm, rather than adding this as another field on the end.

Once 2.6.9 is out and we're open for patches again, I'll break it
into the four parts originally outlined, and send to Andrew.

Hugh

