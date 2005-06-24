Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262956AbVFXIWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbVFXIWO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 04:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbVFXIWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 04:22:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1425 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263226AbVFXIVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 04:21:52 -0400
Date: Fri, 24 Jun 2005 01:21:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: GOTO Masanori <gotom@debian.or.jp>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, gotom@debian.or.jp
Subject: Re: [PATCH] headers 4/4: Clean up byteorder/{little,big}_endian.h
 to use __inline__
Message-Id: <20050624012128.6d54c6bc.akpm@osdl.org>
In-Reply-To: <81is097hne.wl@omega.webmasters.gr.jp>
References: <81is097hne.wl@omega.webmasters.gr.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GOTO Masanori <gotom@debian.or.jp> wrote:
>
> This patch cleans up 2.6.12 byteorder/{little,big}_endian.h to use
>  __inline__ instead of inline because they're included by
>  asm/byteorder.h which also uses __inline__.  In addition, it uses
>  __BYTEORDER_HAS_U64__ that is similar to include/linux/byteorder/swab.h.

I'm not sure that's a good reason for converting `inline' to `__inline__'. 
Generally we use `inline' - it looks nicer.
