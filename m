Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbUBXX6r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 18:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbUBXX5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 18:57:14 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:65451 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S262535AbUBXX4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 18:56:24 -0500
Message-ID: <403BE456.3030102@oracle.com>
Date: Wed, 25 Feb 2004 00:55:02 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20040107
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.3-bk6 JBD assert failure in jbd/transaction.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.3-bk6 hangs hard loading (binary) SmartLink winmodem module,
  and prints an assertion failure in

__journal_unfile_buffer() in jbd/transaction.c at line 1512
  jh->b_jlist < 8

Dead keyboard, can only keep power button pushed to power off.

I know - it's a binary module. The only reason I'm reporting this
  is that same module (2.9.6) works with earlier kernels such as
  2.6.3-rc3-bk1, and the assertion failure is in JBD which doesn't
  seem to have anything to do with the slamr.ko module but has at
  least very small changes in -bk6 that aren't in -bk4; so, it's a
  "just in case" the winmodem module happens to trigger an actual
  bug in the JBD code changes recently introduced.

I'll also report the issue to SmartLink - of course.

--alessandro

  "Two rivers run too deep
   The seasons change and so do I"
       (U2, "Indian Summer Sky")

