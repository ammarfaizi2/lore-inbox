Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbUBKBRM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 20:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbUBKBRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 20:17:12 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:5791 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263607AbUBKBPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 20:15:44 -0500
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Linux Kern <linux-kernel@vger.kernel.org>
Date: Wed, 11 Feb 2004 12:15:41 +1100
Subject: Re: [TRIVIAL patch] 2.6.2-rc2 Remove compile warnings from timer.o
Message-ID: <20040211011541.GE15247@cse.unsw.EDU.AU>
References: <20040211003913.GC15247@cse.unsw.EDU.AU> <20040210165534.3bdc22e3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210165534.3bdc22e3.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Feb 2004, Andrew Morton wrote:

> You should lose the ifdefs.  Just do:
> 
> 	if (SHIFT_SCALE <= (SHIFT_USEC + SHIFT_HZ)) {
> 		if (ltemp < 0)
> 			time_adj -= -ltemp >>
> 				(SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE);
> 		else
> 			time_adj += ltemp >>
> 				(SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE);
> 	}
> 	...
> 
> because
> 
> a) It is not revolting and
> 
> b) The compiler checks the unused code for you, then throws it away.
> 
However this does not remove the compile warnings.

Darren

--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
