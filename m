Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316258AbSILOuL>; Thu, 12 Sep 2002 10:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316289AbSILOuL>; Thu, 12 Sep 2002 10:50:11 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:25077 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S316258AbSILOuK>;
	Thu, 12 Sep 2002 10:50:10 -0400
Date: Fri, 13 Sep 2002 00:55:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] fcntl.h consolidation
Message-Id: <20020913005504.5aa453e9.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New version of the fcntl.h consolidation.  This time,
linux/fcntl.h is a set of default values and structures that
are overridden in the asm/fcntl.h files.

The intention is to stop from happenning what happened to
PPC and PPC64 - which are arbitrarily different but only in
a couple of the defines.

In each case, I have taken the most popular definition among all
the architectures for linux/fcntl.h (this happens to reduce
asm-i386/fcntl.h and a couple of others to effectively empty).

The patch is at http://www.canb.auug.org.au/~sfr/2.5.34-fcntl.2.diff.gz
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
