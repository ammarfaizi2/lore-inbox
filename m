Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317081AbSHJRVL>; Sat, 10 Aug 2002 13:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317083AbSHJRVK>; Sat, 10 Aug 2002 13:21:10 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:57028 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S317081AbSHJRVK>; Sat, 10 Aug 2002 13:21:10 -0400
Date: Sat, 10 Aug 2002 18:23:17 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Paul Larson <plars@austin.ibm.com>, Hubertus Franke <frankeh@us.ibm.com>,
       Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       Andrew Morton <akpm@zip.com.au>, andrea@suse.de,
       Dave Jones <davej@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
Message-ID: <20020810182317.A306@kushida.apsleyroad.org>
References: <1028929600.19435.373.camel@plars.austin.ibm.com> <Pine.LNX.4.33.0208091459010.1283-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0208091459010.1283-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Aug 09, 2002 at 03:04:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Doing a simple strace shows that all the systems I have regular access to
> use the "getcwd()" system call anyway, which gets this right on /proc (and
> other filesystems that do not guarantee unique inode numbers)

Oh dear -- what of programs that assume duplicate inode numbers are hard
links, and therefore assume the same contents will be found in each
duplicate?

-- Jamie
