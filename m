Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbUAOQVB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 11:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264481AbUAOQVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 11:21:01 -0500
Received: from mail.ccur.com ([208.248.32.212]:40454 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S264454AbUAOQU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 11:20:59 -0500
Subject: Re: 2.6.1-mm3 - hangs on shutdown
From: Jim Houston <jim.houston@ccur.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Concurrent Computer Corp.
Message-Id: <1074183626.1696.94.camel@new.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 15 Jan 2004 11:20:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I'm seeing a consistent hang on shutdown on x86_64.  It is a new
behavior since 2.6.1-rc1-mm2.

It hung in wait_for_completion() called from sched_migrate_task() called
from sched_balance_exec().  The migration threads are not in the kgdb
"info thread" list. It looks like they've already been killed.

I can do some more debugging, but I'm hoping someone will own up.

Jim Houston - Concurrent Computer Corp.


