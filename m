Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbTETNs5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 09:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbTETNsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 09:48:53 -0400
Received: from franka.aracnet.com ([216.99.193.44]:56229 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263781AbTETNsr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 09:48:47 -0400
Date: Tue, 20 May 2003 07:01:27 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "David S. Miller" <davem@redhat.com>
cc: haveblue@us.ibm.com, wli@holomorphy.com, arjanv@redhat.com,
       pbadari@us.ibm.com, linux-kernel@vger.kernel.org, gh@us.ibm.com,
       johnstul@us.ibm.com, jamesclv@us.ibm.com, akpm@digeo.com,
       mannthey@us.ibm.com
Subject: Re: userspace irq balancer
Message-ID: <90250000.1053439285@[10.10.2.4]>
In-Reply-To: <20030519.231319.91314647.davem@redhat.com>
References: <20030520034622.GK8978@holomorphy.com><1053407030.13207.253.camel@nighthawk><88560000.1053409990@[10.10.2.4]> <20030519.231319.91314647.davem@redhat.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How does the in-kernel IRQ load balancing measure "load" and
> "busyness"?  Herein lies the most absolutely fundamental problem with
> this code, it fails to recognize that we end up with most of our
> networking "load" from softint context.

OK, that's a great observation, and probably fixable. What were the 
author's comments when you told him that?
 
> rm -rf in-kernel-irqbalance;

It's *very* late in the day to be ripping out such chunks of code.
1. Prove new code works better for you => make it a config option.
2. Prove new code works better for everyone => rip it out.

I think we're at 1, not 2.

Note that the userspace stuff doesn't even require that the kernel
stuff be disabled ... it should just override it (I can believe
there maybe is a bug that needs fixing, but it works by design).

M.

