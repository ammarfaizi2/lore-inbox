Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291988AbSBAUpY>; Fri, 1 Feb 2002 15:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291992AbSBAUpO>; Fri, 1 Feb 2002 15:45:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17156 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291988AbSBAUpB>;
	Fri, 1 Feb 2002 15:45:01 -0500
Message-ID: <3C5AFE2D.95A3C02E@zip.com.au>
Date: Fri, 01 Feb 2002 12:44:29 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ricardo Galli <gallir@uib.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT fails in some kernel and FS
In-Reply-To: <E16WkQj-0005By-00@antoli.uib.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricardo Galli wrote:
> 
> After some comments from Oliver Diedrich (editor of heise.de), which told me
> he couldn't make O_DIRECT work on 2.4.17, I tried with different versions and
> file systems:
> 
> This is the result:
> 
> 2.4.14 - Ext[23] - redhat7.2 glibs: OK (at least the bytes are written)
> 2.4.17 - ReiserFS - Debian Sid    : FAILS (0 bytes file, write returns -1)
> 2.4.17 - Ext2 - Debian Woody      : OK (bytes written)
> 2.4.17 - Ext3 - Debian Woody      : FAILS (0 bytes file, write returns -1)
> 
> Oliver Diedrich also told he could make work O_DIRECT with ext3 and 2.4.17.
> 
> Is this normal? Does it really work on 2.4.14? Or it doesn't but the kernel
> doesn't avoid caching?
> 

ext2 is the only filesystem which has O_DIRECT support.

-
