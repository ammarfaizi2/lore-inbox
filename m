Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283467AbRLOSrc>; Sat, 15 Dec 2001 13:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283496AbRLOSrW>; Sat, 15 Dec 2001 13:47:22 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:44699 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S283467AbRLOSrM>; Sat, 15 Dec 2001 13:47:12 -0500
Date: Sat, 15 Dec 2001 13:47:11 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: mempool design
Message-ID: <20011215134711.A30548@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0112152020030.25153-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112152020030.25153-100000@localhost.localdomain>; from mingo@elte.hu on Sat, Dec 15, 2001 at 08:40:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2001 at 08:40:19PM +0100, Ingo Molnar wrote:
> With all respect, even if i had read it before, i'd have done mempool.c
> the same way as it is now. (but i'd obviously have Cc:-ed Ben on it during
> its development.) I'd like to sum up Ben's patch (Ben please correct me if
> i misrepresent your patch in any way):

You're making the assumption that an incomplete patch is useless and 
has no design pricipals behind it.  What I disagree with is the design 
of mempool, not the implementation.  The design for reservations is to 
use enforced accounting limits to achive the effect of seperate memory 
pools.  Mempool's design is to build seperate pools on top of existing 
pools of memory.  Can't you see the obvious duplication that implies?

The first implementation of the reservation patch is full of bogosities, 
I'm the first one to admit that.  But am I going to go off and write an 
entirely new patch that fixes everything and gets the design right to 
replace mempool?  Not with the current rate of patches being ignored.

		-ben
