Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317791AbSFMR4c>; Thu, 13 Jun 2002 13:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317792AbSFMR4b>; Thu, 13 Jun 2002 13:56:31 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:60384 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317791AbSFMR4b>; Thu, 13 Jun 2002 13:56:31 -0400
To: Alexander Viro <viro@math.psu.edu>
Cc: engler@csl.Stanford.EDU, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
In-Reply-To: <200206130638.XAA08477@csl.Stanford.EDU> <Pine.GSO.4.21.0206130254360.18281-100000@weyl.math.psu.edu>
From: Andi Kleen <ak@muc.de>
Date: 13 Jun 2002 19:56:15 +0200
Message-ID: <m3d6uvxdts.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.070095 (Pterodactyl Gnus v0.95) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> writes:
> 
> I mean that due to the loop (link_path_walk->do_follow_link->foofs_follow_link
> ->vfs_follow_link->link_path_walk) you will get infinite maximal depth
> for everything that can be called by any of these functions.  And that's
> a _lot_ of stuff.

Surely an analysis pass can detect recursive function chains and flag them
(e.g. the global IPA alias analysis pass in open64 does this)

-Andi
