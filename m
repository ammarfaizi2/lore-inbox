Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267837AbRGZWbi>; Thu, 26 Jul 2001 18:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268719AbRGZWbS>; Thu, 26 Jul 2001 18:31:18 -0400
Received: from peace.netnation.com ([204.174.223.2]:47122 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S267837AbRGZWbL>; Thu, 26 Jul 2001 18:31:11 -0400
Date: Thu, 26 Jul 2001 15:31:17 -0700
From: Simon Kirby <sim@netnation.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: read() details
Message-ID: <20010726153116.A11192@netnation.com>
In-Reply-To: <20010726144719.A2098@netnation.com> <E15PtYS-0004dn-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <E15PtYS-0004dn-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jul 26, 2001 at 11:24:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, Jul 26, 2001 at 11:24:28PM +0100, Alan Cox wrote:

> > Is it safe to assume that when a single read() call of x bytes a file
> > (the file being locked against other processes appending to it) returns
> > less than x bytes, the next read() will always return 0?  If so, is it
> 
> No. Posix allows any read to be interrupted. Unix doesn't do this. Even so
> another writer in parallel on the same file will cause what you describe

Well, I was meaning to imply that reads which are interrupted would be
have to be manually restarted.  But yes, there is also no guarantee that
huge reads will not return the requested size, which in effect makes any
don't-read-again-just-to-get-an-EOF optimization more trouble than it
would be worth.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
