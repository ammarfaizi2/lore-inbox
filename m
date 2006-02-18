Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWBRMcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWBRMcs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWBRMcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:32:48 -0500
Received: from 216.255.188.82-custblock.intercage.com ([216.255.188.82]:60626
	"EHLO main.astronetworks.net") by vger.kernel.org with ESMTP
	id S1751198AbWBRMcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:32:47 -0500
From: =?iso-8859-1?q?T=F6r=F6k_Edwin?= <edwin@gurde.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2.6.15.4 1/1][RFC] ipt_owner: inode match supporting both incoming and outgoing packets
Date: Sat, 18 Feb 2006 14:32:14 +0200
User-Agent: KMail/1.9.1
Cc: netfilter-devel@lists.netfilter.org, fireflier-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, martinmaurer@gmx.at
References: <200602181410.59757.edwin.torok@level7.ro> <20060218122512.GG911@infradead.org>
In-Reply-To: <20060218122512.GG911@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602181432.14483.edwin@gurde.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - main.astronetworks.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gurde.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 February 2006 14:25, Christoph Hellwig wrote:
> > - I need to lock the task_list
> > 	- task_list lock export might be gone some day?
>
> yes.  in exactly half a year from now, and no new users are not allowed.
So I'll have to remove all code that relies on the task_list. Is 
proc_check_exe_fown() the only function that is affected by this?
>
> > 	- is locking tasklist when inside a softirq allowed?
>
> no.  for that reason we already removed a broken match from ipt_owner.
Is there an alternative for locking the tasklist, and iterating through all 
the threads to: find out the struct task*  given a struct fown_struct*. Or is 
there any other way to find out the inode, and mountpoint of that process?


Thanks,
Edwin
