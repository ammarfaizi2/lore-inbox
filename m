Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265540AbUAPOYT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 09:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265550AbUAPOYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 09:24:19 -0500
Received: from mail.ccur.com ([208.248.32.212]:36871 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S265540AbUAPOYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 09:24:10 -0500
Date: Fri, 16 Jan 2004 09:23:51 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-ID: <20040116142351.GA2433@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040108051111.4ae36b58.pj@sgi.com> <16381.57040.576175.977969@cargo.ozlabs.ibm.com> <20040108225929.GA24089@tsunami.ccur.com> <16381.61618.275775.487768@cargo.ozlabs.ibm.com> <20040114150331.02220d4d.pj@sgi.com> <20040115002703.GA20971@tsunami.ccur.com> <20040114204009.3dc4c225.pj@sgi.com> <20040115081533.63c61d7f.akpm@osdl.org> <20040115181525.GA31086@tsunami.ccur.com> <20040115211402.04c5c2c4.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115211402.04c5c2c4.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 09:14:02PM -0800, Paul Jackson wrote:
> I give, Joe.  Given the several details that are better with your
> solution, I endorse your solution, with the couple of minor edits you
> have in the pipeline.
> 
> It pains me to see the minor code growth (parsing went from 391 bytes
> of machine code to 625), with non-trivial code duplication of the
> simple_stroull() routine, and admitted increase in code complexity.
> 
> But, yes, better bits than bytes, better not to alloca(), and
> better using existing bitops than misplaced arch dependencies.

First of all, I don't like my parser anymore so I hope you don't back
out, Paul.  Perhaps all that is needed to make your parser acceptable
to Andrew is 1) tweak it to use bitmap_shift_right / set_bit, and 2)
use nbits in the interface but immediately convert it to the nbytes that
the algorithm actually wants.

Over the weekend, I may poke at my version and look over yours again
and perhaps yet a third version will come out of this.  Which is a good
thing since lots of choices to pick and merge from is what is best for
Andrew and for Linux.

Joe
