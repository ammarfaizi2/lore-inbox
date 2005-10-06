Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbVJFSed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbVJFSed (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 14:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbVJFSec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 14:34:32 -0400
Received: from mail.weatherflow.com ([65.57.243.55]:28685 "EHLO
	weatherflow.com") by vger.kernel.org with ESMTP id S1751290AbVJFSec
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 14:34:32 -0400
Message-ID: <43456E31.8000906@weatherflow.com>
Date: Thu, 06 Oct 2005 14:34:25 -0400
From: Robert Derr <rderr@weatherflow.com>
User-Agent: Thunderbird 1.4 (Windows/20050908)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.13.3 Memory leak, names_cache
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: rderr@weatherflow.com
X-Spam-Processed: weatherflow.com, Thu, 06 Oct 2005 14:34:30 -0400
	(not processed: message from valid local sender)
X-MDRemoteIP: 24.227.114.94
X-Return-Path: rderr@weatherflow.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm having a problem with a memory leak in the kernel.  I'm running 
2.6.13.3 from kernel.org on FC4 on a Dell  Poweredge 2850 Duel Xeon 3ghz 
with 2GB RAM.  Soon after booting up names_cache starts growing until it 
consumes all available memory on the system until the oom killer goes 
nuts and starts killing all the processes on the machine.  After 
googling the problem I thought it could be caused by a corrupt file 
system but after running fsck the problem hasn't gone away.  Here's the 
entry from /proc/slabinfo:

names_cache       204686 204686   4096    1    1 : tunables   24   12    
8 : slabdata 204686 204686     12

Anyone have an idea what could cause this problem or point me in the 
correct direction?

Thanks,
Robert J Derr
Weatherflow, Inc.


