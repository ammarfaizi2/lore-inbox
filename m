Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUCBVMU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 16:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbUCBVKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 16:10:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:30373 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261852AbUCBVJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 16:09:43 -0500
Date: Tue, 2 Mar 2004 13:11:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc1-mm1, as scheduler causes higher idle temp?
Message-Id: <20040302131139.0521b9d0.akpm@osdl.org>
In-Reply-To: <4044F25E.3010802@gmx.de>
References: <20040229140617.64645e80.akpm@osdl.org>
	<404367C2.3050109@gmx.de>
	<40448E60.5020403@gmx.de>
	<4044F25E.3010802@gmx.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Prakash K. Cheemplavam" <PrakashKC@gmx.de> wrote:
>
> Comparing dmesg from both, I see this as major differnece: With latest 
> mm-source the as scheduler gets used, though I set elevator=cfq in the 
> kernel line. So either you removed cfq or it doesn't get selcted and 
> maybe anticipatory causes the temp rise?

> -Linux version 2.6.3-mm4 (root@tachyon) (gcc-Version 3.3.3 20040217 
> +Linux version 2.6.4-rc1 (root@tachyon) (gcc-Version 3.3.3 20040217 

The CFQ elevator is not present in Linus's tree.

> -Using cfq io scheduler
> +Using anticipatory io scheduler

So the kernel picked the anticipatory scheduler instead.
