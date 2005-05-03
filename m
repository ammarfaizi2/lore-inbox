Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVECMtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVECMtR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 08:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVECMtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 08:49:16 -0400
Received: from quark.didntduck.org ([69.55.226.66]:53376 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261506AbVECMtO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 08:49:14 -0400
Message-ID: <4277737B.7080709@didntduck.org>
Date: Tue, 03 May 2005 08:50:03 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.2-1 (X11/20050323)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Multithreaded core dump lockup
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running into an intermittent problem with core dumping when cedega 
crashes.  I've traced it down to it deadlocking on the 
wait_for_completion(&startup_done) in fs/exec.c:coredump_wait().  If I 
try to kill the process, it goes into zombie status and takes up 50% cpu 
until I reboot.  The kernel is 2.6.12-rc3 UP on x86_64.  Cedega is a 
32-bit app.  Any help with debugging this would be appreciated.

--
				Brian Gerst
