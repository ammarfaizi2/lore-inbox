Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTG1LVm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 07:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTG1LVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 07:21:41 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10377
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263171AbTG1LV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 07:21:28 -0400
Subject: Re: PATCH: fix 2 byte data leak due to padding
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lou Langholtz <ldl@aros.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F249D42.4010003@aros.net>
References: <200307272019.h6RKJ1Et029763@hraefn.swansea.linux.org.uk>
	 <3F249D42.4010003@aros.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059391969.15438.16.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Jul 2003 12:32:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-28 at 04:49, Lou Langholtz wrote:
> >+	memset(&tmp, 0, sizeof(struct __old_kernel_stat));
> >
> Wouldn't it be more clear (better) to use sizeof(tmp) here rather than 
> sizeof(struct _old_kernel_stat)?

sizeof(variable) can be suprising some times so I always use sizeof(type) out
of habit. (Think sizeof(x) when X later becomes a pointer)

