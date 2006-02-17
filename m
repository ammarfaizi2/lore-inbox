Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbWBQIw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbWBQIw6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 03:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbWBQIw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 03:52:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25508 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932584AbWBQIw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 03:52:57 -0500
Date: Fri, 17 Feb 2006 00:51:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ian Kent <raven@themaw.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       autofs@linux.kernel.org
Subject: Re: [RFC:PATCH 4/4] autofs4 - add new packet type for v5
 communications
Message-Id: <20060217005134.6842f0ca.akpm@osdl.org>
In-Reply-To: <200602170701.k1H71Irp004035@eagle.themaw.net>
References: <200602170701.k1H71Irp004035@eagle.themaw.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent <raven@themaw.net> wrote:
>
> +/* autofs v5 common packet struct */
>  +struct autofs_v5_packet {
>  +	struct autofs_packet_hdr hdr;
>  +	autofs_wqt_t wait_queue_token;
>  +	__u32 dev;
>  +	__u64 ino;
>  +	uid_t uid;
>  +	gid_t gid;
>  +	pid_t pid;
>  +	pid_t tgid;
>  +	int len;
>  +	char name[NAME_MAX+1];
>  +};

Is this known to work with 32-bit userspace on 64-bit kernels?

In particular, perhaps the ?id_t's should become a type of known size and
alignment (u32 or u64)?
