Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129737AbRAEVIb>; Fri, 5 Jan 2001 16:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129561AbRAEVIV>; Fri, 5 Jan 2001 16:08:21 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:29457 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129538AbRAEVIL>; Fri, 5 Jan 2001 16:08:11 -0500
Date: Fri, 05 Jan 2001 16:08:05 -0500
From: Chris Mason <mason@suse.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
Message-ID: <993160000.978728885@tiny>
In-Reply-To: <Pine.LNX.4.21.0101051630150.2882-100000@freak.distro.conectiva>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, January 05, 2001 04:32:50 PM -0200 Marcelo Tosatti
<marcelo@conectiva.com.br> wrote:
 
>> > I think we want to remove flush_dirty_buffers() from bdflush. 
>> > 
>> 
>> Whoops.  If bdflush doesn't balance the dirty list, who does?
> 
> Who marks buffers dirty. 
> 
> Linus changed mark_buffer_dirty() to use flush_dirty_buffers() in case
> there are too many dirty buffers.
> 

Yes, but mark_buffer_dirty only ends up calling flush_dirty_buffers when
balance_dirty_state returns 1.  This means the only people balancing are
the procs (not some async daemon), and the writing only starts when we are
over the hard dirty limit.

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
