Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264152AbTKJWq4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 17:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264153AbTKJWq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 17:46:56 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:58607 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264152AbTKJWqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 17:46:55 -0500
Subject: Re: [ltc-interlock] 2.6.0 kernel: Bind interrupt question.
From: Dave Hansen <haveblue@us.ibm.com>
To: Dong <dvnguyen@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>
In-Reply-To: <OFEED7A2D8.B2402087-ON87256DDA.007B9132@us.ibm.com>
References: <OFEED7A2D8.B2402087-ON87256DDA.007B9132@us.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1068504411.8382.2.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Nov 2003 14:46:51 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-10 at 14:33, Dong V Nguyen wrote:
> Have you seen any problems with interrupt binding on 2.6.0-drv45003 ?
> I tried this command to bind interrupt, but it does not work:
> ============================
> cat  /proc/irq/165/smp_affinity
> ffffffff00000000
> echo 01 > /proc/irq/165/smp_affinity
> cat  /proc/irq/165/smp_affinity
> ffffffff00000000
> ===========================
> There is nothing changed after binding.
> One thing I see is it shows 16 digits "ffffffff00000000" on 2.6.0 while
> only 8 digits in 2.4 .
> Do I need any special ways to bind interrupt ?

Is your architecure broken?

Works fine on x86:
root@foo:/proc/irq# cat 17/smp_affinity 
ffffffff
root@foo:/proc/irq# echo 1 > 17/smp_affinity 
root@foo:/proc/irq# cat 17/smp_affinity 
00010000


-- 
Dave Hansen
haveblue@us.ibm.com

