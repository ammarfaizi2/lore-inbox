Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVCGFcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVCGFcQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 00:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVCGFcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 00:32:16 -0500
Received: from fire.osdl.org ([65.172.181.4]:14226 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261631AbVCGFcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 00:32:06 -0500
Date: Sun, 6 Mar 2005 21:31:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: domen@coderock.org, linux-kernel@vger.kernel.org, nacc@us.ibm.com,
       mochel@digitalimplant.org, greg@kroah.com
Subject: Re: [patch 12/14] drivers/dmapool: use TASK_UNINTERRUPTIBLE instead
 of TASK_INTERRUPTIBLE
Message-Id: <20050306213129.0d6a1504.akpm@osdl.org>
In-Reply-To: <29495f1d0503062101549b14e8@mail.gmail.com>
References: <20050306223654.3EE871EC90@trashy.coderock.org>
	<20050306194414.68239e90.akpm@osdl.org>
	<29495f1d0503062101549b14e8@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
>
> > Also, __set_current_state() can be user here: the add_wait_queue() contains
>  > the necessary barriers.  (Grubby, but we do that in quite a few places with
>  > this particular code sequence (we should have an add_wait_queue() variant
>  > which does the add_wait_queue+__set_current_state all in one hit (but let's
>  > not, else I'll be buried in another 1000 cleanuplets))).
> 
>  Ok, I will re-spin this patch. Or would you prefer an incremental one?

Let's forget about this one while we work out whether that code is doing
what we want it to do.

