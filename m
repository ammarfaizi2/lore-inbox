Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266640AbUBQVon (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266637AbUBQVky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:40:54 -0500
Received: from user-12l28nl.cable.mindspring.com ([69.81.34.245]:29847 "EHLO
	mail.pelennor.net") by vger.kernel.org with ESMTP id S266651AbUBQVi7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:38:59 -0500
Date: Tue, 17 Feb 2004 15:38:58 -0600
From: Matthew Rench <lists@pelennor.net>
To: linux-kernel@vger.kernel.org
Subject: problem rmmod'ing module
Message-ID: <20040217153858.A11859@pelennor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm getting some strange behavior while trying to rmmod a module from my
2.4.21 kernel. Each call to "rmmod" segfaults, leaving the module usage count
incremented. This doesn't seem like something that is supposed to happen,
but I can't understand what the problem is.

When I strace rmmod, the last few lines are:

  query_module(NULL, QM_MODULES, { /* 5 entries */ }, 5) = 0
  query_module("serial", QM_INFO, {address=0xd8816000, size=43620, flags=MOD_RUNNING, usecount=14}, 16) = 0
  query_module( <unfinished ...>
  +++ killed by SIGSEGV +++


I haven't wanted to reboot yet, so I don't know how reproducible this is. (In
fact, I've used this module often on this kernel in the past, and haven't
seen this problem before.) Is there something obvious I am missing?

Thanks,
mdr
