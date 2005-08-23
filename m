Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbVHWIa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbVHWIa6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 04:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbVHWIa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 04:30:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19125 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750962AbVHWIa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 04:30:57 -0400
Date: Tue, 23 Aug 2005 01:28:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pekka Enberg <penberg@gmail.com>
Cc: nathans@sgi.com, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       greg@kroah.com, hch@infradead.org, penberg@cs.helsinki.fi
Subject: Re: sysfs: write returns ENOMEM?
Message-Id: <20050823012839.649645c2.akpm@osdl.org>
In-Reply-To: <84144f02050823005573569fcb@mail.gmail.com>
References: <11394.1124781401@kao2.melbourne.sgi.com>
	<200508190055.25747.dtor_core@ameritech.net>
	<20050823073258.GE743@frodo>
	<84144f02050823005573569fcb@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@gmail.com> wrote:
>
> @@ -310,6 +310,8 @@ ssize_t vfs_write(struct file *file, con
>                  }
>          }
> 
>  +       if (ret == -ENOMEM)
>  +               ret = -ENOBUFS;
>          return ret;
>   }
> 

That's lame.  It'd be better to hunt down all the -ENOMEMs and fix them up.
