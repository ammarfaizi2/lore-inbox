Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129598AbRCAOWu>; Thu, 1 Mar 2001 09:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129599AbRCAOWl>; Thu, 1 Mar 2001 09:22:41 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:12348 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129598AbRCAOWW>; Thu, 1 Mar 2001 09:22:22 -0500
Date: Thu, 1 Mar 2001 15:24:09 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ivan Stepnikov <iv@spylog.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel is unstable
Message-ID: <20010301152409.E32484@athlon.random>
In-Reply-To: <001701c0a230$40e12240$0e04a8c0@iv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001701c0a230$40e12240$0e04a8c0@iv>; from iv@spylog.com on Thu, Mar 01, 2001 at 12:16:08PM +0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2001 at 12:16:08PM +0300, Ivan Stepnikov wrote:
>                 if(p==malloc(block)){

Side note: I guess here you meant:

		  if ((p = malloc(block)) {

Make sure you catch when malloc returns null because of out of memory (the out
of memory in your case happened in the NORMAL zone).

Still the fact it can deadlock the machine is a kernel bug in the memory
management. Probably the 3.5G patch per-task makes simpler to trigger it
because it decreases the size of the normal zone to a few houndred of mbytes.

Andrea
