Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWFSSzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWFSSzd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWFSSzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:55:32 -0400
Received: from zcars04e.nortel.com ([47.129.242.56]:14578 "EHLO
	zcars04e.nortel.com") by vger.kernel.org with ESMTP id S964847AbWFSSzb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:55:31 -0400
Message-ID: <4496F310.9010807@nortel.com>
Date: Mon, 19 Jun 2006 12:55:12 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Srivatsa <vatsa@in.ibm.com>, CKRM <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Sam Vilain <sam@vilain.net>, Con Kolivas <kernel@kolivas.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ckrm-tech] [PATCH 0/4] sched: Add CPU rate caps
References: <20060618082638.6061.20172.sendpatchset@heathwren.pw.nest>
In-Reply-To: <20060618082638.6061.20172.sendpatchset@heathwren.pw.nest>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jun 2006 18:55:17.0179 (UTC) FILETIME=[E7B9A8B0:01C693D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> These patches implement CPU usage rate limits for tasks.

Personally, I'm more comfortable with guarantees rather than limits.

Specifying a limit doesn't do anything to ensure that a task (or group 
of tasks) gets enough cpu time to actually accomplish anything unless 
you specify limits on every task in the system.

Suppose you have a server app that needs at least 50% of the cpu.  With 
a guarantee, you can say "this guy needs 50%, and I don't care about 
anything else".  With limits you have to flip it around--"all these guys 
together are limited to 50%, and that guy isn't limited".  Seems 
counterintuitive.

Chris


