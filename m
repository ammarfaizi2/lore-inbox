Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWAVKGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWAVKGT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 05:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWAVKGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 05:06:19 -0500
Received: from elvis.mu.org ([192.203.228.196]:10459 "EHLO elvis.mu.org")
	by vger.kernel.org with ESMTP id S1751237AbWAVKGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 05:06:18 -0500
Message-ID: <43D3590A.2050803@FreeBSD.org>
Date: Sun, 22 Jan 2006 02:06:02 -0800
From: Suleiman Souhlal <ssouhlal@FreeBSD.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] vfs: propagate mnt_flags into do_loopback/vfsmount
References: <20060121083843.GA10044@MAIL.13thfloor.at> <20060121084055.GC10044@MAIL.13thfloor.at>
In-Reply-To: <20060121084055.GC10044@MAIL.13thfloor.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:
> @@ -1312,7 +1315,7 @@ long do_mount(char *dev_name, char *dir_
>  		retval = do_remount(&nd, flags & ~MS_REMOUNT, mnt_flags,
>  				    data_page);
>  	else if (flags & MS_BIND)
> -		retval = do_loopback(&nd, dev_name, flags & MS_REC);
> +		retval = do_loopback(&nd, dev_name, flags, mnt_flags);

Shouldn't it be retval = do_loopback(&nd, dev_name, recurse, mnt_flags); ?

-- Suleiman
