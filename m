Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133077AbRDRSpm>; Wed, 18 Apr 2001 14:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135223AbRDRSpb>; Wed, 18 Apr 2001 14:45:31 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:14346 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S133077AbRDRSpS>; Wed, 18 Apr 2001 14:45:18 -0400
Date: Wed, 18 Apr 2001 21:00:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Schwartz <davids@webmaster.com>
Cc: Laurent Chavet <lchavet@av.com>, linux-kernel@vger.kernel.org
Subject: Re: Is there a way to turn file caching off ?
Message-ID: <20010418210000.H30770@athlon.random>
In-Reply-To: <3ADD4E61.A2A9CE9@av.com> <NCBBLIEPOCNJOAEKBEAKOEPOOGAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKOEPOOGAA.davids@webmaster.com>; from davids@webmaster.com on Wed, Apr 18, 2001 at 11:21:46AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2001 at 11:21:46AM -0700, David Schwartz wrote:
> 
> 
> 	[..] If we assume the caching isn't helping [..]

If you know kernel data cache doesn't help your workload at all then you want
use O_DIRECT at least to save the CPU.  You can run 2.4.4pre3aa3 or apply the
rawio-3 patch and then the o_direct-2 patch on top of 2.4.4pre3 if you want
O_DIRECT support (it also fixes the O_SYNC wait for locked inode bug noticed by
Marcelo).

You will find detailed explanation on the O_DIRECT feature and where to
find the patches if you grep for subject O_DIRECT in the l-k list in the
messages of this month.

Andrea
