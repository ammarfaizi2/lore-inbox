Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbVBXU3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbVBXU3g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 15:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVBXU3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 15:29:36 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:50634 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262470AbVBXU3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 15:29:31 -0500
Message-ID: <421E3916.6070005@nortel.com>
Date: Thu, 24 Feb 2005 14:29:10 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Chad N. Tindel" <chad@tindel.net>
CC: Paulo Marques <pmarques@grupopie.com>, Mike Galbraith <EFAULT@gmx.de>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
References: <20050224075756.GA18639@calma.pair.com> <30111.1109237503@www1.gmx.net> <20050224175331.GA18723@calma.pair.com> <421E1AC1.1020901@nortel.com> <20050224183851.GA24359@calma.pair.com> <421E2528.8060305@grupopie.com> <20050224192237.GA31894@calma.pair.com> <421E2EF9.9010209@nortel.com> <20050224200802.GA39590@calma.pair.com>
In-Reply-To: <20050224200802.GA39590@calma.pair.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chad N. Tindel wrote:

> OK.  Would you say it would be a reasonable default to have SCHED_FIFO userspace
> threads running at a lower priority than essential kernel threads (say, the
> load balancer and the events thread), and give root the ability to explicitly 
> have userspace threads preempt the kernel?

The current scheduler has a 1-100 priority range for soft realtime 
tasks.  To insert a task into a realtime class, you need to have root 
privileges.

As long as you make sure that kernel threads get set to higher 
priorities than your user threads, then you get the above behaviour. 
Ultimately, however, the administrator is responsable for ensuring that 
everything is running with sane priority levels.

Chris
