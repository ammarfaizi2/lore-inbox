Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWEARFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWEARFe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWEARFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:05:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63896 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932156AbWEARFd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:05:33 -0400
Date: Mon, 1 May 2006 10:03:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel =?ISO-8859-1?B?QXJhZ29u6XM=?= <danarag@gmail.com>
Cc: penberg@cs.helsinki.fi, arjan@infradead.org, linux-kernel@vger.kernel.org,
       jirislaby@gmail.com
Subject: Re: [PATCH/RFC] minix filesystem update to V3 diffed to 2.6.17-rc3
Message-Id: <20060501100328.37527eb2.akpm@osdl.org>
In-Reply-To: <44560796.8010700@gmail.com>
References: <44560796.8010700@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Aragonés <danarag@gmail.com> wrote:
>
> +	char *offset = kmalloc(sizeof(char *), GFP_NOFS);
>  +	bh = sbi->s_imap[ino >> k];
>  +	offset = (char *)bh->b_data;

It is still the case that the memory which was allocated here gets leaked. 
There are several instances of this.

