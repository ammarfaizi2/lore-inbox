Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264093AbTEXGaz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 02:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbTEXGaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 02:30:55 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:29708 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S264093AbTEXGay
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 02:30:54 -0400
Date: Sat, 24 May 2003 08:43:40 +0200
From: Willy Tarreau <willy@w.ods.org>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Willy Tarreau <willy@w.ods.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, gibbs@scsiguy.com
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
Message-ID: <20030524064340.GA1451@alpha.home.local>
References: <1053732598.1951.13.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053732598.1951.13.camel@mulgrave>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 07:29:53PM -0400, James Bottomley wrote:
     
> I think there's some misunderstanding about what a release candidate
> is.  It's an attempt to see if a particular set of code is viable as the
> released product.  Any bugs reported against a rc that are deemed
> problems to the release need to be fixed, either by adding a simple and
> easily verifiable bug fix or by reverting the problem code.

That's also my point. People were reporting problems till -rc1 which included
driver version 6.2.28. So Marcelo reverted to 6.2.8 for -rc2 (74500 lines of
code reverted, not including doc nor aic79xx which was kept). Then, people were
still reporting problems with -rc2 which they claim are fixed by updating
to last driver updates, which were 16000 lines forward from -rc1, so less than
one fourth of what Marcelo accepted to change from -rc1 to -rc2. Although I
find this big, it's less than the change in fusion/mpt* that has gone from
-rc2 to -rc3. So I think it's not a matter of size here.

> The bksend file on http://people.freebsd.org/~gibbs/linux/SRC/
> representing the requested updates is 475k compressed.  There's no
> definition of the phrase "simple and easily verifiable bug fix" I can
> encompass that could be applied to a chunk of code that size.

Most of this is a 1 MB Changelog, files going back to their original place
(Marcelo moved aic79xx to a proper directory to keep it), documentation, and
initialization code which was exploded in more little functions, then bug fixes.

I wish Justin would have proposed a little patch to fix only the locking bugs
in -rc1, but honnestly, why should he fix only these bugs when he knows about
others that must be fixed too ? I can understand he gives up. -rc is for bug
fixes, and his bug fixes are reverted !

As I said, I really hope that we'll have a quick 2.4.22 with bug fixes taken
as a priority. The current pre-releases are as frequent and as big as what
used to be full releases in the past.

Regards,
Willy

