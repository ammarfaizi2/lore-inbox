Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVAGUxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVAGUxG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 15:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVAGUvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 15:51:06 -0500
Received: from pagoda.mtholyoke.edu ([138.110.30.68]:13466 "EHLO
	pagoda.mtholyoke.edu") by vger.kernel.org with ESMTP
	id S261589AbVAGUui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 15:50:38 -0500
From: Ron Peterson <rpeterso@mtholyoke.edu>
Date: Fri, 7 Jan 2005 15:50:31 -0500
To: Robert Love <rml@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/random vs. /dev/urandom
Message-ID: <20050107205031.GA14599@mtholyoke.edu>
References: <20050107190536.GA14205@mtholyoke.edu> <1105126843.9311.41.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105126843.9311.41.camel@betsy.boston.ximian.com>
Organization: Mount Holyoke College
X-Operating-System: Debian GNU/Linux
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 02:40:43PM -0500, Robert Love wrote:
> On Fri, 2005-01-07 at 14:05 -0500, Ron Peterson wrote:
> 
> >     read( fd, dat, RAND_LEN );
> >     for( i = 0; i < RAND_LEN; i++ ) {
> >       dat[i] = (dat[i] & 0x07) + '0';
> >     }
> 
> Your problem is probably because read() need not actually read RAND_LEN
> bytes.  Particularly with /dev/random, since it will only return bytes
> up to the entropy estimate.  But you assume it read RAND_LEN, when those
> are unread.  And possibly zero.  So that is probably your bug.
> 
> The AND makes zero sense, either.
>
> Just use dd(1).

Ah, thanks! (to you and everyone else.)

(I can't use dd because I want to use the value to feed gmp_randseed
from gmp library.  I need the AND to create the proper ascii code for a
numeral.)

Best.

-- 
Ron Peterson
Network & Systems Manager
Mount Holyoke College
http://www.mtholyoke.edu/~rpeterso
