Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbVKGRIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbVKGRIo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbVKGRIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:08:44 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:42416 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S932296AbVKGRIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:08:43 -0500
Message-ID: <436F8A06.7090409@nortel.com>
Date: Mon, 07 Nov 2005 11:08:22 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: scheduler parameter inheritance on clone()
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2005 17:08:24.0127 (UTC) FILETIME=[DCB794F0:01C5E3BD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The pthreads standard specifies that the default behaviour is that new 
threads should be created with the SCHED_OTHER policy and a priority of 0.

However, it appears that the kernel will create new tasks (be they 
threads or processes) with the same settings as the parent.

If CLONE_THREAD is set, should the kernel perhaps set the policy and 
priority as specified by pthreads?

Chris
