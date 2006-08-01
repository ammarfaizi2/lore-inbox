Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWHAQ3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWHAQ3p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 12:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWHAQ3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 12:29:45 -0400
Received: from xenotime.net ([66.160.160.81]:21191 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750815AbWHAQ3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 12:29:44 -0400
Date: Tue, 1 Aug 2006 09:32:24 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jan-Frode Myklebust <mykleb@no.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oom_adj/oom_score documentation
Message-Id: <20060801093224.bb3736fe.rdunlap@xenotime.net>
In-Reply-To: <20060801141307.GA18159@99RXZYP.ibm.com>
References: <OFF927B0C7.8C7E4394-ONC12571BC.003A43D2-C12571BC.003B49E8@no.ibm.com>
	<20060731122314.GL6455@opteron.random>
	<20060801133323.GA10128@99RXZYP.ibm.com>
	<20060801134102.GA6455@opteron.random>
	<20060801141307.GA18159@99RXZYP.ibm.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006 16:13:08 +0200 Jan-Frode Myklebust wrote:

> I was looking for the a way around an OOM-problem, and found
> a couple of undocumented new features for tuning the OOM-score
> of individual processes. Here's a small documentation patch for
> /proc/<pid>/oom_adj and /proc/<pid>/oom_score.

Thanks, it's needed.

A few comments below.


> Signed-off-by: Jan-Frode Myklebust <mykleb@no.ibm.com>
> 
> ---
> 
> diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
> index 99902ae..81bb8ea 100644
> --- a/Documentation/filesystems/proc.txt
> +++ b/Documentation/filesystems/proc.txt
> @@ -39,6 +39,8 @@ Table of Contents
>    2.9	Appletalk
>    2.10	IPX
>    2.11	/proc/sys/fs/mqueue - POSIX message queues filesystem
> +  2.12	/proc/<pid>/oom_adj - Adjust the oom-killer score
> +  2.13	/proc/<pid>/oom_score - Display current oom-killer score
>  
>  ------------------------------------------------------------------------------
>  Preface
> @@ -1958,6 +1960,21 @@ a queue must be less or equal then msg_m
>  maximum  message size value (it is every  message queue's attribute set during
>  its creation).
>  
> +2.12 /proc/<pid>/oom_adj - Adjust the oom-killer score
> +------------------------------------------------------
> +
> +This file can be used to adjust the score used to select which processes shall
> +be killed in an out-of-memory situation.  Giving it a high score, increase the

Drop the comma.  "increases"

> +likelihood of this process being killed by the oom-killer. Valid values are in
> +the range [-16:15], plus the special value '-17', which defeat the  oom-killer

"defeats"

> +altogether.
> +
> +2.13 /proc/<pid>/oom_score - Display current oom-killer score
> +-------------------------------------------------------------
> +
> +This file can be used to check what the  current score  used by the oom-killer
> +is for any given <pid>. Use it together with /proc/<pid>/oom_adj to tune which
> +process will be killed in an out-of-memory situation.
>  
>  ------------------------------------------------------------------------------
>  Summary


---
~Randy
