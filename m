Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVAXSbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVAXSbA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 13:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVAXSa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 13:30:59 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:15043 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S261559AbVAXSax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 13:30:53 -0500
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Enable swsusp on SMP machines
In-Reply-To: <20050124171943.GA2499@elf.ucw.cz>
References: <20050124171943.GA2499@elf.ucw.cz>
Date: Mon, 24 Jan 2005 18:30:52 +0000
Message-Id: <E1Ct8zE-0002TK-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:

> -	/* Suspend is hard to get right on SMP. */
> -	if (num_online_cpus() != 1) {
> -		error = -EPERM;
> +	if (state == PM_SUSPEND_DISK) {
> +		error = pm_suspend_disk();
>  		goto Unlock;
>  	}
>  
> -	if (state == PM_SUSPEND_DISK) {
> -		error = pm_suspend_disk();
> +	/* Suspend is hard to get right on SMP. */
> +	if (num_online_cpus() != 1) {
> +		error = -EPERM;
>  		goto Unlock;
>  	}

Are you sure about this?

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
