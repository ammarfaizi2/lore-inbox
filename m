Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264111AbUCZSTL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 13:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264118AbUCZSTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 13:19:11 -0500
Received: from mtagate7.de.ibm.com ([195.212.29.156]:17031 "EHLO
	mtagate7.de.ibm.com") by vger.kernel.org with ESMTP id S264111AbUCZSTH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 13:19:07 -0500
Date: Fri, 26 Mar 2004 19:18:53 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: s390 patches for -bk.
Message-ID: <20040326181853.GA2523@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
its time again for an s390 update. One bigger patch, splitted in
two parts so that they make it over lkml. The purpose of the big
one is to speed up system calls on s390. I managed to squeeze
about 65 cycles from each system call. This improved e.g. getpid()
from 232 to 157 cycles. As a nice side-effect it simplified the
uaccess functions considerably.

Short descriptions:
1) s390 core fixes.
2) Dasd driver fixes.
3) z/VM monitor stream module fixes.
4) Network driver fixes.
5) Tape driver fixes.
6) System call speedup part 1.
7) System call speedup part 2.

The patches applied without rejects on todays bitkeeper and
2.6.5-rc2-mm3.

blue skies,
  Martin.

