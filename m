Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268115AbTGIK3W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 06:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268143AbTGIK3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 06:29:22 -0400
Received: from air-2.osdl.org ([65.172.181.6]:27110 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268115AbTGIK1w (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 06:27:52 -0400
Date: Wed, 9 Jul 2003 03:42:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Linux-Kernel@vger.kernel.org
Subject: Re: [PATCH] 1/5 VM changes: zone-pressure.patch
Message-Id: <20030709034251.6902c488.akpm@osdl.org>
In-Reply-To: <16139.60502.110693.175421@laputa.namesys.com>
References: <16139.54887.932511.717315@laputa.namesys.com>
	<20030709031203.3971d9b4.akpm@osdl.org>
	<16139.60502.110693.175421@laputa.namesys.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <Nikita@Namesys.COM> wrote:
>
>  > OK, fixes a bug.
> 
>  What bug?

Failing to consider mapped pages on the active list until the scanning
priority gets large.

I ran up your five patches on a 256MB box, running `qsbench -m 350'.  It got
all slow then the machine seized up.   I'll poke at it some.

