Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbTDUNNo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 09:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbTDUNNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 09:13:44 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:59309 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261165AbTDUNNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 09:13:43 -0400
Message-ID: <3EA3F153.3000106@colorfullife.com>
Date: Mon, 21 Apr 2003 15:25:39 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org
Subject: Q: nr_threads locking
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

According to the comments, nr_threads is protected by lock_kernel, but 
do_fork() runs without the bkl for ages.
Would it be possible to use your percpu_counters for nr_threads? It 
seems to be used only to guard against fork bombs and for i_nlink of /proc.

--
    Manfred

