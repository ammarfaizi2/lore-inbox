Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262819AbVF3N4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbVF3N4N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 09:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbVF3N4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 09:56:13 -0400
Received: from [195.23.16.24] ([195.23.16.24]:44244 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262819AbVF3N4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 09:56:10 -0400
Message-ID: <42C3F9DD.8080502@grupopie.com>
Date: Thu, 30 Jun 2005 14:55:41 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>
Cc: linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>, John McCutchan <ttb@tentacle.dhs.org>
Subject: Re: [patch] latest inotify.
References: <1119989024.6745.20.camel@betsy>
In-Reply-To: <1119989024.6745.20.camel@betsy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> Below is the latest inotify patch, against 2.6.12.
> 
> [...]
> +/*
> + * fsnotify_oldname_init - save off the old filename before we change it
> + *
> + * XXX: This could be kstrdup if only we could add that to lib/string.c
> + */

I knew you were waiting for this, so I just wanted to let you know that 
the kstrdup function is already available in Linus tree 2.6.13-rc1. It 
is declared linux/string.h and implemented in mm/slab.c.

It is not implemented in lib/string.c because some architectures use lib 
functions in their bootloading code where the allocation functions are 
not available, and the linking stage then fails because of the kmalloc 
reference :P

-- 
Paulo Marques - www.grupopie.com

It is a mistake to think you can solve any major problems
just with potatoes.
Douglas Adams
