Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbWFSWCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWFSWCo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 18:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWFSWCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 18:02:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57787 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964930AbWFSWCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 18:02:43 -0400
Date: Mon, 19 Jun 2006 15:05:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: mingo@elte.hu, arjan@infradead.org, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com
Subject: Re: [patch 8/8] lock validator: add s390 to supported options
Message-Id: <20060619150547.0b6213b1.akpm@osdl.org>
In-Reply-To: <20060614142503.GI1241@osiris.boeblingen.de.ibm.com>
References: <20060614142503.GI1241@osiris.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
>
>  config DEBUG_SPINLOCK_ALLOC
>  	bool "Spinlock debugging: detect incorrect freeing of live spinlocks"
> -	depends on DEBUG_SPINLOCK && X86
> +	depends on DEBUG_SPINLOCK && (X86 || S390)

Can we please stomp this out before it starts to look like
CONFIG_FRAME_POINTER?

We should define CONFIG_ARCH_SUPPORTS_LOCKDEP down in
arch/[i386|x86_64|s390]/Kconfig and use that in lib/Kconfig.debug.

