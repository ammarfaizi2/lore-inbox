Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUGHQpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUGHQpS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 12:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264625AbUGHQpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 12:45:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:35254 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264153AbUGHQpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 12:45:14 -0400
Date: Thu, 8 Jul 2004 09:44:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Autotune swappiness
Message-Id: <20040708094406.2b0293ea.akpm@osdl.org>
In-Reply-To: <40ED7534.4010409@kolivas.org>
References: <40EC13C5.2000101@kolivas.org>
	<40EC1930.7010805@comcast.net>
	<40EC1B0A.8090802@kolivas.org>
	<20040707213822.2682790b.akpm@osdl.org>
	<cone.1089268800.781084.4554.502@pc.kolivas.org>
	<20040708001027.7fed0bc4.akpm@osdl.org>
	<cone.1089273505.418287.4554.502@pc.kolivas.org>
	<20040708010842.2064a706.akpm@osdl.org>
	<40ED7534.4010409@kolivas.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> Here is another try at providing feedback to tune the vm_swappiness.

I spent some time yesterday trying to demonstrate performance improvements
from those two patches.  Using

	make -j4 vmlinux with mem=64m

and

	qsbench -p 4 -m 96 with mem=256m

and was not able to do so, which is what I expected.

We do need more quantitative testing on this work.
