Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316503AbSGLRv7>; Fri, 12 Jul 2002 13:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316739AbSGLRv6>; Fri, 12 Jul 2002 13:51:58 -0400
Received: from pD9E235D3.dip.t-dialin.net ([217.226.53.211]:34437 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316503AbSGLRv5>; Fri, 12 Jul 2002 13:51:57 -0400
Date: Fri, 12 Jul 2002 11:53:22 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Roman Zippel <zippel@linux-m68k.org>
cc: Thunder from the hill <thunder@ngforever.de>,
       Dawson Engler <engler@csl.stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <mc@cs.stanford.edu>
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
In-Reply-To: <Pine.LNX.4.44.0207121934420.8911-100000@serv>
Message-ID: <Pine.LNX.4.44.0207121151180.3421-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 12 Jul 2002, Roman Zippel wrote:
> Please drop this patch, it's impossible to hit this problem and I have a
> better patch for this.

You mean

static inline int affs_rmdir(struct inode *dir, struct dentry *dentry)
{
	int res;
	lock_kernel();
	res = affs_remove_header(dentry);
	unlock_kernel();
	return res;
}

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

