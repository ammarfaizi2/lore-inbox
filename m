Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbTE3O3o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 10:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263709AbTE3O3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 10:29:44 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:6155 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S263705AbTE3O3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 10:29:43 -0400
Date: Fri, 30 May 2003 16:43:02 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Stewart Smith <stewartsmith@mac.com>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: buffer_head.b_bsize type
Message-ID: <20030530164302.A2721@pclin040.win.tue.nl>
References: <746529B0-91C0-11D7-9488-00039346F142@mac.com> <20030529103503.GZ8978@holomorphy.com> <20030529111517.GP14138@parcelfarce.linux.theplanet.co.uk> <20030529112841.GA8978@holomorphy.com> <20030530162434.A2700@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030530162434.A2700@pclin040.win.tue.nl>; from aebr@win.tue.nl on Fri, May 30, 2003 at 04:24:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 04:24:34PM +0200, Andries Brouwer wrote:
> On Thu, May 29, 2003 at 04:28:41AM -0700, William Lee Irwin III wrote:
> 
> > The thought behind my comment was that it didn't make sense to allow
> > the representation to go negative. There of course shouldn't ever be
> > any need to allow >= 2GB b_size to be representable.
> 
> Not about this particular case, but as a general remark:
> Use of unsigned is dangerous - use of int is far preferable,
> everywhere that is possible.
> 
> With ints the test a+b > c is equivalent to the test a > c-b.

[of course I meant: With smallish ints, so that no overflow occurs]

> As soon as there is some unsigned in an expression comparisons
> get counterintuitive because -1 is very large.
> Thus, 1+sizeof(int) > 3 is true, but 1 > 3-sizeof(int) is false.
> 
> It has happened several times that kernel code was broken because
> some variable (that always was nonnegative) was made unsigned.
> 
> Andries

