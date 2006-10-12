Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422761AbWJLDvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422761AbWJLDvR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 23:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422755AbWJLDvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 23:51:17 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:11537 "EHLO
	asav07.insightbb.com") by vger.kernel.org with ESMTP
	id S1422761AbWJLDvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 23:51:16 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FANlWLUWBSopPLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: spin_[un]lock_bh() compile problem on UP
Date: Wed, 11 Oct 2006 23:51:12 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610112351.13499.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

I am getting the following warning when I try compiling latest pull
from Linus on UP with kernel debuggin disabled.

drivers/input/ff-memless.c: In function `ml_ff_set_gain':
drivers/input/ff-memless.c:384: warning: implicit declaration of function `local_bh_disable'
drivers/input/ff-memless.c:393: warning: implicit declaration of function `local_bh_enable'

Should linux/spinlock_api_up.h do #include <linux/interrupt.h>?

-- 
Dmitry
