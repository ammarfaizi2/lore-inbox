Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVF0HMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVF0HMB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 03:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVF0HLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 03:11:49 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:46016 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261910AbVF0HI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 03:08:26 -0400
Message-ID: <42BFA5C6.9040604@jp.fujitsu.com>
Date: Mon, 27 Jun 2005 16:07:50 +0900
From: Naoaki Maeda <maeda.naoaki@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Gerrit Huizenga <gh@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net, Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [ckrm-tech] [patch 25/38] CKRM e18: Add fork rate control to
 the numtasks controller
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com> <20050623061759.325157000@w-gerrit.beaverton.ibm.com>
In-Reply-To: <20050623061759.325157000@w-gerrit.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerrit Huizenga wrote:

> +As with any other resource under the CKRM framework, numtasks also assigns
> +all the resources to the detault class(/rcfs/taskclass). Since , the number
> +of tasks in a system is not limited, this resource controller provides a
> +way to set the total number of tasks available in the system through the config
> +file. By default this value is 128k(131072). In other words, if not changed,
> +the total number of tasks allowed in a system is 131072.
> +
> +The config variable that affect this is sys_total_tasks.

Because there are people who do not want to use the numtask controller,
no limit is a preferable default value for sys_total_tasks.

> +Usage
> +-----
> +
> +For brevity, unless otherwise specified all the following commands are
> +executed in the default class (/rcfs/taskclass).
> +
> +As explained above the config file shows sys_total_tasks and forkrate
> +info.
> +
> +   # cd /rcfs/taskclass
> +   # cat config
> +   res=numtasks,sys_total_tasks=131072,forkrate=1000000,forkrate_interval=3600
> +
> +By default, the sys_total_tasks is set to 131072(128k), and forkrate is set
> +to 1 million and forkrate_interval is set to 3600 seconds. Which means the
> +total number of tasks in a system is limited to 131072 and the forks are
> +limited to 1 million per hour.

>From the same point of view, the default value of forkrate should be
no limit. (In addition, 1 million tasks per hour is not an abnormally
high rate.)

Thanks,
MAEDA Naoaki

