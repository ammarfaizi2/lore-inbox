Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267650AbUBTBfK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 20:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267667AbUBTBfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 20:35:10 -0500
Received: from [218.38.13.88] ([218.38.13.88]:11984 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S267650AbUBTBei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 20:34:38 -0500
Date: Fri, 20 Feb 2004 10:34:30 +0900
To: linux-kernel@vger.kernel.org
Subject: Regarding character encoding of filesystem names
Message-ID: <20040220013429.GA5211@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Tejun Huh <tj@home-tj.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, guys,

 I've just seen the LWN summary of discussions regarding filename
charset encoding and read some of the threads.  I had the same issues
myself and have been working on a solution.  A new locale LC_FSCTYPE
is introduced to specify the charset encoding of filenames and libc
sits between the kernel and application and translates the charsets of
LC_CTYPE and LC_FSCTYPE appropriately. As proof-of-concept, I've
implemented a preloading library (libfsxlat) which overrides affected
libc functions. The README file contains detailed description of the
solution.

 http://home-tj.org/libfsxlat/
 http://home-tj.org/libfsxlat/files/README
 http://home-tj.org/libfsxlat/screenshots.html

 I'm currently working on merging LC_FSCTYPE into glibc and I believe
it's almost done.  LC_FSCTYPE implementation in glibc includes iconv
caching and the syntax of LC_FSCTYPE is changed such that it's
identical to other locales.  Any comments are welcomed and please
don't forget to CC me as I'm not on the list.

 Cheers.

-- 
tejun
