Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbTKJW6v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 17:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264151AbTKJW6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 17:58:51 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:16776 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264165AbTKJW6t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 17:58:49 -0500
Importance: Normal
Sensitivity: 
Subject: Re: 2.6.0 kernel: Bind interrupt question.
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
From: Dong V Nguyen <dvnguyen@us.ibm.com>
Date: Mon, 10 Nov 2003 15:58:45 -0700
Message-ID: <OF7D31CE33.45677759-ON87256DDA.007DFB46@us.ibm.com>
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 11/10/2003 15:58:47
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Anton,
You're right. By defaut, the CONFIG_NR_CPUS is set to 32.
I need to reset that and rebuild the kernel to try the interrupt binding
again.
Thanks,



Anton Blanchard <anton@samba.org> on 11/10/2003 04:48:22 PM

To:    Dong V Nguyen/Austin/IBM@IBMUS
cc:    linux-kernel@vger.kernel.org
Subject:    Re: 2.6.0 kernel: Bind interrupt question.




Hi,

> Have you seen any problems with interrupt binding on 2.6.0-drv45003 ?
> I tried this command to bind interrupt, but it does not work:
> ============================
> cat  /proc/irq/165/smp_affinity
> ffffffff00000000
> echo 01 > /proc/irq/165/smp_affinity
> cat  /proc/irq/165/smp_affinity
> ffffffff00000000

This is probably a ppc64 specific issue, we can continue this on
linuxppc64-dev@lists.linuxppc.org

> There is nothing changed after binding.
> One thing I see is it shows 16 digits "ffffffff00000000" on 2.6.0 while
> only 8 digits in 2.4 .

Its part of the support for > 32way machines, but it looks like its
broken for some configurations (Im guessing you have CONFIG_NR_CPUS set
to 32).

 Anton


