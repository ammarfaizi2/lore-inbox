Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbTE0POu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 11:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263854AbTE0POu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 11:14:50 -0400
Received: from garnet.acns.fsu.edu ([146.201.2.25]:61118 "EHLO
	garnet.acns.fsu.edu") by vger.kernel.org with ESMTP id S263850AbTE0POt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 11:14:49 -0400
Message-ID: <3ED383E7.6080109@cox.net>
Date: Tue, 27 May 2003 11:27:35 -0400
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [2.5.70-bk1] Compilation failures ppa.c imm.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a compilation error on line 280 of ppa.c.
Should
	if (ppa_hosts[i] == host)
Be
	if ((struct Scsi_Host *)&ppa_hosts[i] == host)
??

Also, imm.c fails to compile on line 112 claiming that imm_proc_info is 
undeclared by that point.
Any questions?

-David

