Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbUCQU3i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 15:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbUCQU3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 15:29:37 -0500
Received: from mail.ccur.com ([208.248.32.212]:7951 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S261961AbUCQU3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 15:29:36 -0500
Subject: Async I/O POSIX compliance
From: Jason Baietto <jason.baietto@ccur.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1079555358.21791.23.camel@sprout>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Wed, 17 Mar 2004 15:29:19 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running some internally developed AIO tests and have discovered two
behaviors that appear to disagree with POSIX:

aio_read operations with bogus file descriptors or bogus signal numbers
in their aiocbp structures are simply ignored without error conditions
being returned.

aio_cancel isn't returning the appropriate values when all operations
have already completed.

I'm not sure exactly where to direct this information, though.  Any
pointers would be appreciated...

Take care,
Jason


