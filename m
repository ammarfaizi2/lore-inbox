Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbTENPpT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 11:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbTENPpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 11:45:19 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:37573 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261177AbTENPpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 11:45:16 -0400
Date: Wed, 14 May 2003 17:57:27 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Ahmed Masud <masud@googgun.com>
Cc: Yoav Weiss <ml-lkml@unpatched.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: encrypted swap [was: The disappearing sys_call_table export.]
Message-ID: <20030514155727.GA16093@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0305140234110.32259-100000@marcellos.corky.net> <Pine.LNX.4.33.0305140513460.10480-100000@marauder.googgun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0305140513460.10480-100000@marauder.googgun.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003 06:06:56 -0400, Ahmed Masud wrote:
> On Wed, 14 May 2003, Yoav Weiss wrote:
> > On Tue, 13 May 2003, Ahmed Masud wrote:
> >
> > Yes, it sounds like an interesting project.  Check out openbsd's paper
> > about this: http://www.openbsd.org/papers/swapencrypt.ps
> 
> Thank you for this paper, it is a fun read. I do think however that a
> few implementation differences should take place:
> 
> 1. We should not enforce Rijndael as the only choice.
> 
> 2. Every page should be encrypted iff it marked with some flag. This gives
> a generic enough hook to create a swap_encrypt_policy type function to
> determine whether it is desirable to encrypt a particular page or not.
>
> [...]

Just browsed across the white paper, but this doesn't make a lot of
sense to me.

1. Instead of cryptographic filesystems, you could just encrypt the
   block device.
2. The only reason not to do so it security.  An attacker could use
   known-plaintext attacks, since some parts of the metadata can be
   reconstructed or guessed easily.
3. Instead of encrypted swap, you could just encrypt the block device.
4. The only reason reason not to do so is what?

Sorry, beats me, I cannot see any reason. Is there a possible
known-plaintext attack possible, that is not obvious to everyone, at
least not to me?

Jörn

-- 
A defeated army first battles and then seeks victory.
-- Sun Tzu
