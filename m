Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTE2KFd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 06:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTE2KFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 06:05:33 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:32499 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S262095AbTE2KFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 06:05:32 -0400
Message-ID: <3ED5DE49.5CA79049@wipro.com>
Date: Thu, 29 May 2003 15:47:45 +0530
From: Arvind Kandhare <arvind.kan@wipro.com>
X-Mailer: Mozilla 4.61 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       "indou.takao" <indou.takao@jp.fujitsu.com>, rml <rml@tech9.net>,
       Dave Jones <davej@suse.de>, roystgnr@owlnet.rice.edu,
       garagan@borg.cs.dal.ca, arvind.kan@wipro.com
Subject: Re: Changing SEMVMX to a tunable parameter
References: <3ED4C6B6.7050806@wipro.com> <3ED4E0BB.2080603@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 May 2003 10:18:35.0606 (UTC) FILETIME=[A9EE4760:01C325CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> _If_ there are no signed/unsigned problems and if Oracle wants 64K, then 
> I would increase SEMVMX to 64K, without making it tunable. Dito for SEMAEM.
> 

1. Most of the IPC parameters (e.g. msgmni, msgmax, 
msgmnb , shmmni, shmmax) are tunables. 

(Please refer : 
http://web.gnu.walfield.org/mail-archive/linux-kernel-digest/1999-November/0020.html)

Was there any specific reason why semvmx was not made a tunable with the 
above set??  

2. By having semvmx as tunable, administrator gets more flexibility 
in controlling the resource usage on the system:
        a. By increasing this, it is possible to allow more     
        processes to use the system resources controlled by a
        semaphore concurrently.

        b. By decreasing this, the number of processes
        using the system resources controlled by a semaphore
        concurrently can be limited.

Tuning this value may be desirable so that system is run at optimum 
performance. We are working towards avoiding kernel re-build for any 
desired value of semvmx. This will be most desirable in enterprise 
systems.

Because of problems with dynamic tuning (ref first mail on the subject), 
static tuning (boot time) is proposed.

Please let us know your comments.

thanks and regards,
Arvind
