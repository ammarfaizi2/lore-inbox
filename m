Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265897AbUFVWJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265897AbUFVWJf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 18:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265794AbUFVWIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 18:08:41 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:34990 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265737AbUFVWIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 18:08:15 -0400
Date: Tue, 22 Jun 2004 15:08:13 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: linux ia64 kernel <linux-ia64@vger.kernel.org>
Subject: Does parallel make work for modules?
Message-ID: <20040622220813.GA306@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When building 2.6.7 on a 4way Linux/ia64, "make -j4 modules" doesn't
spawn 4 jobs. I got

 5756 pts/0    S      0:00 make -s -j4 modules
 5868 pts/0    S      0:00 make -f scripts/Makefile.build obj=fs
 7240 pts/0    S      0:00 make -f scripts/Makefile.build obj=fs/nfs
 7269 pts/0    S      0:00 /bin/sh -c set -e; ?   gcc -Wp,-MD,fs/nfs/.pagelist.o. 
 7270 pts/0    S      0:00 gcc -Wp,-MD,fs/nfs/.pagelist.o.d -nostdinc -iwithprefi
 7271 pts/0    S      0:00 /usr/gcc-3.4/libexec/gcc/ia64-unknown-linux-gnu/3.4.1/
 7272 pts/0    R      0:00 as -x -o fs/nfs/pagelist.o -

2.4 kernel module build work fine. Any ideas?


H.J.
