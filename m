Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932613AbWCHWYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbWCHWYF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 17:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbWCHWYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 17:24:05 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:19074
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932534AbWCHWYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 17:24:01 -0500
Date: Wed, 08 Mar 2006 14:24:01 -0800 (PST)
Message-Id: <20060308.142401.72886733.davem@davemloft.net>
To: paulus@samba.org
Cc: duncan.sands@math.u-psud.fr, dhowells@redhat.com, akpm@osdl.org,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, mingo@redhat.com, linuxppc64-dev@ozlabs.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Document Linux's memory barriers
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <17423.21837.304330.623519@cargo.ozlabs.ibm.com>
References: <9551.1141762147@warthog.cambridge.redhat.com>
	<200603080925.19425.duncan.sands@math.u-psud.fr>
	<17423.21837.304330.623519@cargo.ozlabs.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Mackerras <paulus@samba.org>
Date: Thu, 9 Mar 2006 09:06:05 +1100

> I'd be interested to know what the C standard says about whether the
> compiler can reorder writes that may be visible to a signal handler.
> An interrupt handler in the kernel is logically equivalent to a signal
> handler in normal C code.
> 
> Surely there are some C language lawyers on one of the lists that this
> thread is going to?

Just like for setjmp() I think you have to mark such things
as volatile.
