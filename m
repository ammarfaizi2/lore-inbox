Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279623AbRJ2X3k>; Mon, 29 Oct 2001 18:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279616AbRJ2X3f>; Mon, 29 Oct 2001 18:29:35 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:18459 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S279617AbRJ2X3N>; Mon, 29 Oct 2001 18:29:13 -0500
Date: Mon, 29 Oct 2001 18:29:49 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
Message-ID: <20011029182949.H25434@redhat.com>
In-Reply-To: <20011029.151422.102554141.davem@redhat.com> <Pine.LNX.4.33.0110291520260.16656-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0110291520260.16656-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Oct 29, 2001 at 03:22:28PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 03:22:28PM -0800, Linus Torvalds wrote:
> Does it make the accessed bit less reliable? Sure it does. But basically,
> either the page is accessed SO much that it stays in the TLB all the time
> (which is basically not really possible if you page heavily, I suspect),
> or it will age out of the TLB on its own at which point we get the
> accessed bit back.

Think of CPUs with tagged tlbs and lots of entries.  Or even a system that 
only runs 1 threaded app.  Easily triggerable.  If people want to optimise 
it, great.  But go for correctness first, please...

		-ben
