Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262201AbVCPA6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbVCPA6L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 19:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVCPA6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 19:58:11 -0500
Received: from fire.osdl.org ([65.172.181.4]:1247 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262201AbVCPA6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 19:58:05 -0500
Date: Tue, 15 Mar 2005 16:57:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: mpm@selenic.com, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] SquashFS
Message-Id: <20050315165747.3c242dd5.akpm@osdl.org>
In-Reply-To: <42376ED3.4090502@lougher.demon.co.uk>
References: <4235BC29.2060009@lougher.demon.co.uk>
	<20050315031251.GI3163@waste.org>
	<42376ED3.4090502@lougher.demon.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Lougher <phillip@lougher.demon.co.uk> wrote:
>
> >>+	unsigned int		s_major:16;
>  >>+	unsigned int		s_minor:16;
>  > 
>  > 
>  > What's going on here? s_minor's not big enough for modern minor
>  > numbers.
>  > 
> 
>  What is the modern size then?

10 bits of major, 20 bits of minor.

As this is an on-disk thing, you're kinda stuck.  A number of filesystems
have this problem.  We used tricks in the inode to support it in ext2 and
ext3.
