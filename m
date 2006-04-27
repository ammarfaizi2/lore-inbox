Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWD0Bgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWD0Bgh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 21:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWD0Bgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 21:36:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7885 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964872AbWD0Bgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 21:36:37 -0400
Date: Wed, 26 Apr 2006 18:34:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, ak@suse.de,
       ralf@linux-mips.org, paulus@samba.org, schwidefsky@de.ibm.com,
       lethal@linux-sh.org, kkojima@rr.iij4u.or.jp, ysato@users.sourceforge.jp
Subject: Re: [PATCH] Handle CONFIG_LBD and CONFIG_LSF in one place
Message-Id: <20060426183442.78e40e3b.akpm@osdl.org>
In-Reply-To: <20060419140540.GK24104@parisc-linux.org>
References: <20060419140540.GK24104@parisc-linux.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <matthew@wil.cx> wrote:
>
>  CONFIG_LBD and CONFIG_LSF are spread into asm/types.h for no particularly
>  good reason.  Centralising the definition in linux/types.h means that arch
>  maintainers don't need to bother adding it, as well as fixing the problem
>  with x86-64 users being asked to make a decision that has absolutely no
>  effect.  The H8/300 porters seem particularly confused since I'm not aware
>  of any microcontrollers that need to support 2TB filesystems these days.

x86_64:

include/linux/types.h:137: error: conflicting types for 'sector_t'
include/asm/types.h:51: error: previous declaration of 'sector_t' was here

