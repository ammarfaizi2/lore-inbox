Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286372AbSAEXTs>; Sat, 5 Jan 2002 18:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286371AbSAEXTj>; Sat, 5 Jan 2002 18:19:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:263 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286372AbSAEXTS>; Sat, 5 Jan 2002 18:19:18 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: losetuping files in tmpfs fails?
Date: 5 Jan 2002 15:18:49 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a181kp$tl4$1@cesium.transmeta.com>
In-Reply-To: <3C35F8B2.98763627@sltnet.lk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3C35F8B2.98763627@sltnet.lk>
By author:    Ishan Oshadi Jayawardena <ioshadi@sltnet.lk>
In newsgroup: linux.dev.kernel
> 
> 	No, there isn't. I noticed this myself a few months back, but didn't
> complain because, well, the purpose of tmpfs is to provide support for
> POSIX shared memory, right? (At least according to Configure.help).
> {If,/ Because} tmpfs does that correctly, it's not broken.
> 

That was the original reason for it, when it was called "shmfs".  It
has become more than that, due to the fairly clever observation that
"shmfs" already supported virtually everything needed for a swappable
temporary-storage general filesystem.

	-hpa

P.S. On kernel.org, I was forced to hack tmpfs so that it returns a
nonzero size for directories; otherwise "make distclean" breaks for
older Linux kernels, and the incdiff robot that runs on kernel.org
relies on this operation working correctly.  It would be a good thing
if tmpfs could account for the amount of memory consumed by
directories, etc.
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
