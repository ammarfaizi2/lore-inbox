Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbVKRII0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbVKRII0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 03:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbVKRII0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 03:08:26 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:63945
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964845AbVKRII0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 03:08:26 -0500
Date: Fri, 18 Nov 2005 00:08:02 -0800 (PST)
Message-Id: <20051118.000802.81426185.davem@davemloft.net>
To: hugh@veritas.com
Cc: nickpiggin@yahoo.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] unpaged: COW on VM_UNPAGED
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0511180730530.5435@goblin.wat.veritas.com>
References: <437D6AD0.5080909@yahoo.com.au>
	<20051117.224516.118147408.davem@davemloft.net>
	<Pine.LNX.4.61.0511180730530.5435@goblin.wat.veritas.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugh Dickins <hugh@veritas.com>
Date: Fri, 18 Nov 2005 08:02:02 +0000 (GMT)

> That code is necessary to reproduce the existing behaviour, which has
> always done COW on PageReserved mappings without complaint - if the
> vm_page_prot didn't already let you slip through without a WP fault.

And there is evidence today that this is really needed, at least
by vbetool.

Ok, we need COW on VM_UNPAGED. :)
