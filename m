Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269915AbRHJGRq>; Fri, 10 Aug 2001 02:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269916AbRHJGRg>; Fri, 10 Aug 2001 02:17:36 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:5896 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S269915AbRHJGRa>; Fri, 10 Aug 2001 02:17:30 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Fri, 10 Aug 2001 08:17:08 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.4.4: thread dumping core
CC: linux-kernel@vger.kernel.org
Message-ID: <3B739883.8859.1BE32B@localhost>
In-Reply-To: <3B72C08E.3800.1F80245@localhost> from "Ulrich Windl" at Aug 09, 2001 04:55:46 PM
In-Reply-To: <E15UrQ3-0007Qq-00@the-village.bc.nu>
X-mailer: Pegasus Mail for Win32 (v3.12c)
X-Content-Conformance: HerringScan-0.9/3.47+2.4+2.03.072+02 July 2001+64930@20010810.061232Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Aug 2001, at 16:08, Alan Cox wrote:

> > I wonder whether the kernel does the right thing if a thread causes a 
> > segmentation violation: Currently it seems the other LWPs just 
> > continue. However in practice this means that the application does not 
> 
> This is a feature in most cases
> 
> > I suggest to terminate all LWPs if one receives a fatal signal.
> 
> So write some signal handlers. 

Actually I'm using a wrapper library that is supposed to do that stuff 
for me (libmilter from sendmail-8.12.0.Beta16).

> 
> In all cases the other threads will continue for some time, so you gain
> nothing by pretending they dont. 

Imagine you aquire a lock in one thread then that thread gets a 
SIGSEGV. There are a lot of threads around, possibly consuming a lot of 
CPU without getting any (a lot of) work done.

Maybe the real problem is a simple a a binary incompatibility between 
libpthread form SuSE 7.1 and SuSE 7.2 (which would be a very bad case).
As for any real bug, the application works most of the time.

Thanks for the statement.

Ulrich

