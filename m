Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVCGAev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVCGAev (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 19:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVCGAev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 19:34:51 -0500
Received: from fire.osdl.org ([65.172.181.4]:15064 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261509AbVCGAet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 19:34:49 -0500
Date: Sun, 6 Mar 2005 16:34:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: domen@coderock.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 04/12] drivers/net/myri_code.h cleanup
Message-Id: <20050306163447.2f776a0d.akpm@osdl.org>
In-Reply-To: <20050305153518.9CA5D1F07A@trashy.coderock.org>
References: <20050305153518.9CA5D1F07A@trashy.coderock.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

domen@coderock.org wrote:
>
> Cleanup initialization to 0.
> 
> Basically it does:
> -static unsigned char lanai4_data[20472] __initdata = {
> -0x00,0x00,
> - a bunch of zeroes
> -0x00,0x00, 0x00,0x00, 0x00,0x00, } ;
> +static unsigned char lanai4_data[20472] __initdata = { };

Fair enough.  If someone regenerates that header then we'll be back to the
same silliness.  I guess we just need to keep an eye out for that.
