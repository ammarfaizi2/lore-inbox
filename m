Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281128AbRLLQnf>; Wed, 12 Dec 2001 11:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279418AbRLLQnY>; Wed, 12 Dec 2001 11:43:24 -0500
Received: from ppp-130-18.29-151.libero.it ([151.29.18.130]:45296 "HELO
	blu.blu.i.prosa.it") by vger.kernel.org with SMTP
	id <S281128AbRLLQnL>; Wed, 12 Dec 2001 11:43:11 -0500
Date: Wed, 12 Dec 2001 17:35:17 +0100
From: antirez <antirez@invece.org>
To: Joe Wong <joewong@tkodog.no-ip.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IP -> hostname lookup in kernel module?
Message-ID: <20011212173517.G17064@blu>
Reply-To: antirez <antirez@invece.org>
In-Reply-To: <1008174218.3c17848ab4b69@home.hjc.edu.sg> <Pine.LNX.4.33.0112130035070.2697-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112130035070.2697-100000@localhost.localdomain>; from joewong@tkodog.no-ip.com on Thu, Dec 13, 2001 at 12:36:06AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2001 at 12:36:06AM +0800, Joe Wong wrote:
> Hi,
> 
>   Is there such a thing in kernel like gethostbyaddr in user space?

There isn't, but you can create an UDP socket and to the query,
or run an userspace resolver daemon that talks with your
module, or some other trick.

BTW it isn't the kind of stuff to do in kernelspace.
You may think about do it in a post-processing stage
if possible, or to write a module that exports to userspace
what you need from the kernel and do the rest in userspace.

-- 
Salvatore Sanfilippo <antirez@invece.org>
http://www.kyuzz.org/antirez
finger antirez@tella.alicom.com for PGP key
28 52 F5 4A 49 65 34 29 - 1D 1B F6 DA 24 C7 12 BF
