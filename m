Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279627AbRJ2XdA>; Mon, 29 Oct 2001 18:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279616AbRJ2Xcv>; Mon, 29 Oct 2001 18:32:51 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:36636 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S279627AbRJ2Xcj>; Mon, 29 Oct 2001 18:32:39 -0500
Date: Mon, 29 Oct 2001 18:33:16 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
Message-ID: <20011029183315.I25434@redhat.com>
In-Reply-To: <20011029181527.G25434@redhat.com> <Pine.LNX.4.33.0110291522490.16656-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0110291522490.16656-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Oct 29, 2001 at 03:25:36PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 03:25:36PM -0800, Linus Torvalds wrote:
> And avoiding the extra TLB flush (for _every_ page scanned) is noticeable
> according to Andrea.

Sure.  But do it correctly and perform a tlb flush higher up in the page 
table walking code.  Just deleting it entirely is bogus.  Introducing 
hard to track down bugs is just stupid.

		-ben
