Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264107AbTE0Ubx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264122AbTE0Ubp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:31:45 -0400
Received: from cecchetti.com ([208.31.215.234]:59321 "EHLO cecchetti.com")
	by vger.kernel.org with ESMTP id S264107AbTE0Ubh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:31:37 -0400
Subject: [2.5.70-bk1] Compilation failures riscom8.c
From: Adam Cecchetti <adam@cecchetti.com>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3ED383E7.6080109@cox.net>
References: <3ED383E7.6080109@cox.net>
Content-Type: text/plain
Message-Id: <1054068236.4657.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 27 May 2003 16:43:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/riscom8.h 
line 85: struct tq_struct	tqueue;
line 86: struct tq_struct	tqueue_hangup;

I can't find where/what tq_struct should be declared
>From looking at simular drivers should tq_struct be work_struct?



drivers/char/riscom8.c 
line 349:  mark_bh(RISCOM8_BH);
line 1707: init_bh(RISCOM8_BH, do_riscom_bh);
RISCOM8_BH is also missing


