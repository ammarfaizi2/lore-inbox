Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136488AbRD3Q4V>; Mon, 30 Apr 2001 12:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136489AbRD3Q4L>; Mon, 30 Apr 2001 12:56:11 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4105 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136488AbRD3Qz5>; Mon, 30 Apr 2001 12:55:57 -0400
Subject: Re: Alpha compile problem solved by Andrea (pte_alloc)
To: andrea@suse.de (Andrea Arcangeli)
Date: Mon, 30 Apr 2001 17:56:41 +0100 (BST)
Cc: ebiederm@xmission.com (Eric W. Biederman),
        mag@fbab.net ("Magnus Naeslund(f)"),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <20010430014653.C923@athlon.random> from "Andrea Arcangeli" at Apr 30, 2001 01:46:53 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uGya-0008He-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On alpha it's racy if you set CONFIG_ALPHA_LARGE_VMALLOC y (so don't do
> that as you don't need it). As long as you use only 1 entry of the pgd
> for the whole vmalloc space (CONFIG_ALPHA_LARGE_VMALLOC n) alpha is
> safe.

Its racy for all cases on the Alpha because the exception table fixes are
not done.

> OTOH x86 is racy and there's no workaround available at the moment.

-ac fixes all known problems there 

Alan

