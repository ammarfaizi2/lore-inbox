Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286303AbSBOCNP>; Thu, 14 Feb 2002 21:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286322AbSBOCNG>; Thu, 14 Feb 2002 21:13:06 -0500
Received: from mail.headlight.de ([195.254.117.141]:54539 "EHLO
	mail.headlight.de") by vger.kernel.org with ESMTP
	id <S286303AbSBOCMu>; Thu, 14 Feb 2002 21:12:50 -0500
Date: Fri, 15 Feb 2002 03:13:42 +0100
From: Daniel Mack <daniel@yoobay.net>
To: Ken Brownfield <brownfld@irridia.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] + [PATCH]: handling bad inodes in 2.4.x kernels
Message-ID: <20020215031342.B19035@chaos.intra>
In-Reply-To: <20020213182927.I15910@chaos.intra> <20020214193319.C1518@asooo.flowerfire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020214193319.C1518@asooo.flowerfire.com>; from brownfld@irridia.com on Thu, Feb 14, 2002 at 07:33:19PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2002 at 07:33:19PM -0600, Ken Brownfield wrote:
> One could argue that a corrupt filesystem is a corrupt filesystem, but

but a corrupted filesystem should not change the behaviour of the entire
kernel. write-opening a bad inode should not end up with the effect that 
the rename() syscall does not work anymore, i wasn't even able to securely
shut down by box everytime that happend.

> I've seen this behavior first hand (without using debugfs,
> unfortunately). 

thats how i found that bug - it exists in real life.

> I think it's worth someone with filesystem fu taking a
> look at this patch.  Or "seconded", whatever. :)

there's another possibilty for fixing this in my latest posting.


daniel
