Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263751AbUC3RAz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 12:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263756AbUC3RAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 12:00:55 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:16825 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S263751AbUC3RAt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 12:00:49 -0500
Message-ID: <4069A7DC.4060107@mellanox.co.il>
Date: Tue, 30 Mar 2004 19:01:16 +0200
From: Eli Cohen <mlxk@mellanox.co.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: how to avoid low memory situation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Our driver is locking user space memory by calling sys_mlock() while the 
processes are ordinary processes without root priviliges. However it 
happens that the system has low memory since there have been many 
processes that locked memory and another attempt to lock memory brings 
the system to a state in which it struggles to find some free pages and 
the system becomes none responsive. Checking just the amount of free 
pages just before attempting to lock is not so good since there may be a 
lot of pages used by various caches which could be reduced thus allowing 
to lock memory. I am seeking a method in which I can forsee if another 
attempt to lock memory will bring me to such a condition and thus avoid it.

thanks for any help
Eli
