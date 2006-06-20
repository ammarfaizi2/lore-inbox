Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWFTGyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWFTGyw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 02:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWFTGyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 02:54:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59365 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964897AbWFTGyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 02:54:51 -0400
Date: Mon, 19 Jun 2006 23:54:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Frank Gevaerts <frank.gevaerts@fks.be>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, lcapitulino@mandriva.com.br
Subject: Re: [RESEND] [PATCH 2/2] ipaq.c timing parameters
Message-Id: <20060619235440.1be20ac3.akpm@osdl.org>
In-Reply-To: <20060619084619.GB17103@fks.be>
References: <20060619084446.GA17103@fks.be>
	<20060619084619.GB17103@fks.be>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006 10:46:19 +0200
Frank Gevaerts <frank.gevaerts@fks.be> wrote:

> Adds configurable waiting periods to the ipaq connection code. These are
> not needed when the pocketpc device is running normally when plugged in,
> but they need extra delays if they are physically connected while
> rebooting.
> There are two parameters :
> * initial_wait : this is the delay before the driver attemts to start the
>   connection. This is needed because the pocktpc device takes much
>   longer to boot if the driver starts sending control packets too soon.
> * connect_retries : this is the number of times the control urb is
>   retried before finally giving up. The patch also adds a 1 second delay
>   between retries.
> I'm not sure if the cases where this patch is useful are general enough
> to include this in the kernel.
> 
> ..
>
> +module_param(connect_retries, int, S_IRUGO|S_IWUSR);
> +MODULE_PARM_DESC(connect_retries, "Maximum number of connect retries (100ms each)");

1000ms, methinks.
