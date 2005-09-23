Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbVIWSYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbVIWSYW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 14:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVIWSYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 14:24:22 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:50035 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751122AbVIWSYV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 14:24:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RiNvMiIkNbF5zILcPp7mz0zbXTCI9PBAIFXQYdSf9zQC/zHSD2BbI5ninFVLuTmGehGKLJsRy/KuzMqs1TduT2AGYUhiGNCoivwHBFm8EXngOlZTLjj2a156gjTAqIt8HsvPKqMnWQ/ruirzeRDJaFmJWYiwE3lQexXL1yODMLw=
Message-ID: <29495f1d05092311244895d723@mail.gmail.com>
Date: Fri, 23 Sep 2005 11:24:19 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [patch] sys_epoll_wait() timeout saga ...
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/05, Davide Libenzi <davidel@xmailserver.org> wrote:
>
> The sys_epoll_wait() function was not handling correctly negative timeouts
> (besides -1), and like sys_poll(), was comparing millisec to secs in
> testing the upper timeout limit.
>
>
> Signed-off-by: Davide Libenzi <davidel@xmailserver.org>

Looks a lot more correct :)

Probably want to eventually convert the code path to be similar to
sys_poll(), though? Maybe with a helper to do the converting? I think
the epoll code can probable use msecs_to_jiffies() + 1 as well, no? I
will wait for your patch to go in and send a patch for these ideas
later.

Thanks,
Nish
