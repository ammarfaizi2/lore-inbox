Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVCMNwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVCMNwL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 08:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVCMNwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 08:52:11 -0500
Received: from smtpout.mac.com ([17.250.248.86]:43999 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261264AbVCMNwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 08:52:07 -0500
In-Reply-To: <Pine.GSO.4.44.0503122327090.7685-100000@elaine24.Stanford.EDU>
References: <Pine.GSO.4.44.0503122327090.7685-100000@elaine24.Stanford.EDU>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0EFE5EBF-93C7-11D9-A59F-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Miklos Szeredi <miklos@szeredi.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fuse-devel@lists.sourceforge.net, mc@cs.stanford.edu
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [MC] [CHECKER] Need help on mmap on FUSE (linux user-land file system)
Date: Sun, 13 Mar 2005 08:51:54 -0500
To: Junfeng Yang <yjf@stanford.edu>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 13, 2005, at 02:28, Junfeng Yang wrote:
> Forget to mention, we are checking linux 2.6.  It appears to us that 
> mmap
> doesnt' work for FUSE in linux 2.6.

IIRC, the reason mmap doesn't work on FUSE is because when it dirties 
pages they
cannot be flushed reliably, because writing them out involves calling a 
userspace
process which may allocate RAM, etc.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


