Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262860AbVEHMtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbVEHMtO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 08:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbVEHMtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 08:49:14 -0400
Received: from coderock.org ([193.77.147.115]:34786 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262860AbVEHMtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 08:49:11 -0400
Date: Sun, 8 May 2005 14:49:04 +0200
From: Domen Puncer <domen@coderock.org>
To: gh@us.ibm.com
Cc: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [patch 21/21] CKRM: Fix for compiler warnings
Message-ID: <20050508124904.GA4535@nd47.coderock.org>
References: <20050505180731.010896000@us.ibm.com> <20050505180936.211142000@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050505180936.211142000@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/05 11:07 -0700, gh@us.ibm.com wrote:
> -static void cb_taskclass_newtask(struct task_struct *tsk)
> +static void cb_taskclass_newtask(void *tsk1)
>  {
> +	struct task_struct *tsk = (struct task_struct *)tsk1;
> +

I see this often in this code, so I'll mention it:
There's no need to cast void pointers to other pointers.


	Domen

