Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318893AbSHSOiG>; Mon, 19 Aug 2002 10:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318896AbSHSOiG>; Mon, 19 Aug 2002 10:38:06 -0400
Received: from angband.namesys.com ([212.16.7.85]:50823 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S318893AbSHSOiF>; Mon, 19 Aug 2002 10:38:05 -0400
Date: Mon, 19 Aug 2002 18:42:08 +0400
From: Oleg Drokin <green@namesys.com>
To: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com, viro@math.psu.edu
Subject: Need more symbols to be exported out of kernel
Message-ID: <20020819184208.A11022@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   I have implemented file_operations->write() function for reiserfs for
   linux kernel v2.4, and it seems I need these symbols to be exported
   out of kernel for a case when reiserfs is built as a module:
   generic_osync_inode
   remove_suid
   block_commit_write

   I need block_commit_write just because generic_commit_write is doing
   some extra stuff I'd better do myself.
   Will the patch to export these symbols be accepted? (should these be
   exported as GPL sysmbols or not?).

   You can look a my current code on top of 2.4.20-pre2+ at
   ftp://ftp.namesys.com/pub/reiserfs-for-2.4/2.4.19.pending/testing

Bye,
    Oleg
