Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264641AbUESWNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264641AbUESWNf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 18:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264585AbUESWNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 18:13:35 -0400
Received: from mail.kssb.net ([198.248.45.1]:30690 "EHLO california.campus")
	by vger.kernel.org with ESMTP id S264641AbUESWNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 18:13:33 -0400
Message-ID: <40ABDC0F.8020207@kssb.net>
Date: Wed, 19 May 2004 17:13:35 -0500
From: Bradley Hook <bhook@kssb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: System-call auditing
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 May 2004 22:13:29.0563 (UTC) FILETIME=[83C7B2B0:01C43DEE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to put this system-call auditing to use, and I'm running into 
some trouble figuring it out. I've been studying the sources for the 
auditd example app and the audit.c/auditsc.c kernel files, and have yet 
to figure out how to accomplish my goal.

What I am trying to do is detect when a modified file is closed. I 
figured auditing __NR_open, __NR_write, and __NR_close would be the way 
to do this (perhaps I am wrong here?). My problem is that I haven't 
found a way to tie the open/write/close calls together with the info 
that the auditing code provides.

The audit info for __NR_open provides the filename (which I would need 
when my app goes to work) but doesn't provide any unique identifier that 
I can use to tie it to audits on __NR_write or __NR_close.

If anyone can give me some pointers on how to use this auditing code I 
would greatly appreciate it.

~Brad
