Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317101AbSHJRwI>; Sat, 10 Aug 2002 13:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317102AbSHJRwI>; Sat, 10 Aug 2002 13:52:08 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:1221 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S317101AbSHJRwH>; Sat, 10 Aug 2002 13:52:07 -0400
Date: Sat, 10 Aug 2002 18:55:08 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
Message-ID: <20020810185508.A423@kushida.apsleyroad.org>
References: <20020810183604.B306@kushida.apsleyroad.org> <Pine.LNX.4.44.0208101041500.2197-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208101041500.2197-100000@home.transmeta.com>; from torvalds@transmeta.com on Sat, Aug 10, 2002 at 10:46:30AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> For people like that, wouldn't it be nice to just be able to tell them: if 
> you do X, we guarantee that you'll get optimal zero-copy performance for 
> reading a file.

Don't forget to include the need for mmap(... MAP_ANON ...) prior to the
read.

Given the user will need to establish a new mapping anyway, why pussy
foot around with subtleties?  Just add a MAP_PREFAULT flag to mmap(),
which reads the whole file and maps it before returning.

-- Jamie
