Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbVKPIeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbVKPIeY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 03:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbVKPIeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 03:34:24 -0500
Received: from mail1.kontent.de ([81.88.34.36]:25494 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S1030225AbVKPIeX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 03:34:23 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Wed, 16 Nov 2005 09:34:21 +0100
User-Agent: KMail/1.8
Cc: Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
References: <20051116005034.73421.qmail@web50210.mail.yahoo.com> <1132128212.2834.17.camel@laptopd505.fenrus.org>
In-Reply-To: <1132128212.2834.17.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511160934.21444.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 16. November 2005 09:03 schrieb Arjan van de Ven:
> * less CPU cache footprint due to interrupt stacks
>    - interrupt stacks are per cpu now instead of borrowing the per
>      thread stack space; this both has less impact on the caches, and
>      has more cache hits; the per cpu stack will be in cache more than
>      the previously scattered bits and pieces
> * more stack space is available for interrupts compared to 2.4 kernels
>    - in 2.4 kernels only 2Kb was available for interrupt context (to
>      keep 4K available for user context). With complex softirqs such as
>      PPP and firewall rules and nested interrupts this wasn't always
>      enough. Compared to 2.6-with-8Kstacks is a bit harder; there is
>      2Kb extra available there compared to 2.4 and arguably some of that
>      extra is for interrupts.

This is due to having interrupt stacks. Is there any reason not to have
8K task stacks and per CPU interrupt stacks?

	Regards
		Oliver

