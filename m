Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTILSSg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbTILSSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:18:36 -0400
Received: from paiol.terra.com.br ([200.176.3.18]:27611 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S261825AbTILSSe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:18:34 -0400
Message-ID: <3F620E61.4080604@terra.com.br>
Date: Fri, 12 Sep 2003 15:20:17 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: rusty@rustcorp.com.au
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] kernel/futex.c: Uneeded memory barrier
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Rusty,

	Patch against 2.6-test5.

	Kills an unneeded set_current_state after schedule_timeout, since it 
already guarantees that the task will be TASK_RUNNING.

	Also, when setting the state to TASK_RUNNING, isn't that memory 
barrier unneeded? Patch removes this memory barrier too.

	If it looks good, please consider applying.

	Thanks.

Felipe

