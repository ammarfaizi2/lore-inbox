Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284677AbRLEUS1>; Wed, 5 Dec 2001 15:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284663AbRLEUQ7>; Wed, 5 Dec 2001 15:16:59 -0500
Received: from leeloo.zip.com.au ([203.12.97.48]:20232 "EHLO
	mangalore.zipworld.com.au") by vger.kernel.org with ESMTP
	id <S284645AbRLEUQq>; Wed, 5 Dec 2001 15:16:46 -0500
Message-ID: <3C0E809B.49D659A4@zip.com.au>
Date: Wed, 05 Dec 2001 12:16:27 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: io scheduling / serializing io requests / readahead
In-Reply-To: <Pine.LNX.4.30.0112051824120.2754-100000@mustard.heime.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
> 
> hi
> 
> Are there any ways to tell Linux to use some sort of readahead
> functionality that'll give me the ability to schedule I/O more loosely, so
> some 100 files can be read concurrently without ruining the system by
> seeking all the time?

There's a new system call sys_readhead() which may provide what you
want.

A simple alternative is to just cat each file, one at a time
onto /dev/null before the application starts up.

> I've tried to alter /proc/sys/vm/(min|max)-readahead, but it doesn't have
> any effect...
> 

Yup.  We covered that in the other thread.
