Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265700AbSLQRzU>; Tue, 17 Dec 2002 12:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265736AbSLQRzU>; Tue, 17 Dec 2002 12:55:20 -0500
Received: from tolkor.SGI.COM ([198.149.18.6]:9947 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S265700AbSLQRzT>;
	Tue, 17 Dec 2002 12:55:19 -0500
Subject: Re: Compile warnings due to missing __inline__ in fs/xfs/xfs_log.h
From: Stephen Lord <lord@sgi.com>
To: Thomas Schlichter <schlicht@rumms.uni-mannheim.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1040140891.3dff4a5bcf8f5@rumms.uni-mannheim.de>
References: <1040140891.3dff4a5bcf8f5@rumms.uni-mannheim.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 17 Dec 2002 11:55:18 -0600
Message-Id: <1040147719.1368.424.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-17 at 10:01, Thomas Schlichter wrote:
> As the __inline__ directive in front of the _lsn_cmp function is not used with
> the gcc version 2.95.x, compile-warnings result from many files including this
> header-file.
> 
> Is there any reason why this function is not inlined with these compiler
> versions? As I used following patch and compiled the kernel with my
> gcc2.95.3(SuSE) and an other gcc2.95.4(Debian) these compiler warnings
> disappeared and no additional warning or error occured...

The reason inline is turned off for this compiler version is that it
generates bad code when inlining this code. So you can have a quiet
compile, or bad code.

Steve



