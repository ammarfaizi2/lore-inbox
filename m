Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269639AbTHBQyp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 12:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269671AbTHBQyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 12:54:45 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:10515 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269639AbTHBQyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 12:54:45 -0400
Date: Sat, 2 Aug 2003 17:54:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Joe Thornber <thornber@sistina.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 3/6] dm: decimal device num sscanf
Message-ID: <20030802175401.A31970@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Joe Thornber <thornber@sistina.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
	Linux Mailing List <linux-kernel@vger.kernel.org>
References: <20030731104517.GD394@fib011235813.fsnet.co.uk> <20030731104953.GG394@fib011235813.fsnet.co.uk> <20030731160429.A14613@infradead.org> <20030731151326.GZ394@fib011235813.fsnet.co.uk> <20030731162000.A15112@infradead.org> <20030731152454.GA394@fib011235813.fsnet.co.uk> <20030731171443.A23456@infradead.org> <20030731162745.GE394@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030731162745.GE394@fib011235813.fsnet.co.uk>; from thornber@sistina.com on Thu, Jul 31, 2003 at 05:27:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 05:27:45PM +0100, Joe Thornber wrote:
> > So why do you do it in kernel again?
> 
> Let's reverse the question, why are you deprecating passing a dev_t
> into the kernel ?  (I'm not being awkward, just confused).

Because we want to keep dev_t use down as much as possible.  It should
just be a small cookie for looking up the correspoding object where
it's required by posix.  Everywhere outside that scope we better deal
with pathnames because they are much more meaningfull.  And with udev
and dynamic dev_t around the corner the actual values become more and
more meaningless.

