Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbTGXT27 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 15:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268019AbTGXT27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 15:28:59 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:62202 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S263187AbTGXT26
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 15:28:58 -0400
Subject: Re: [uClinux-dev] Kernel 2.6 size increase - get_current()?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: David McCullough <davidm@snapgear.com>, uclinux-dev@uclinux.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <B45078B7-BDEB-11D7-B453-000A95A0560C@us.ibm.com>
References: <B45078B7-BDEB-11D7-B453-000A95A0560C@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059075436.7998.58.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Jul 2003 20:37:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-24 at 16:30, Hollis Blanchard wrote:
> So you're arguing for more inlining, because icache speculative 
> prefetch will pick up the inlined code?

I'm arguing for short inlined fast paths and non inlined unusual
paths.

> Or you're arguing for less, because code like get_current() which is 
> called frequently could have a single copy living in icache?

Depends how much the jump costs you.

