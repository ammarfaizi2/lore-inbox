Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266347AbUGAWRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266347AbUGAWRB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 18:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266328AbUGAWRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 18:17:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:15579 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266322AbUGAWQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 18:16:51 -0400
Date: Thu, 1 Jul 2004 15:19:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] task name handling in proc fs
Message-Id: <20040701151935.1f61793c.akpm@osdl.org>
In-Reply-To: <20040701220510.GA6164@w-mikek2.beaverton.ibm.com>
References: <20040701220510.GA6164@w-mikek2.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz <kravetz@us.ibm.com> wrote:
>
> --- linux-2.6.7/fs/proc/array.c	Wed Jun 16 05:19:36 2004
> +++ linux-2.6.7.ptest/fs/proc/array.c	Thu Jul  1 17:44:14 2004
> @@ -97,14 +97,14 @@
>  		name++;
>  		i--;
>  		*buf = c;
> -		if (!c)
> +		if (!*buf)
>  			break;
> -		if (c == '\\') {
> -			buf[1] = c;
> +		if (*buf == '\\') {
> +			buf[1] = *buf;
>  			buf += 2;
>  			continue;
>  		}
> -		if (c == '\n') {
> +		if (*buf == '\n') {
>  			buf[0] = '\\';
>  			buf[1] = 'n';
>  			buf += 2;

What is this code for?
