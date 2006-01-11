Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWAKIgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWAKIgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 03:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbWAKIgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 03:36:14 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:28363
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932358AbWAKIgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 03:36:12 -0500
Date: Wed, 11 Jan 2006 00:36:08 -0800 (PST)
Message-Id: <20060111.003608.126208924.davem@davemloft.net>
To: arjan@infradead.org
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: ntohs/ntohl and bitops
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1136967192.2929.6.camel@laptopd505.fenrus.org>
References: <43C42F0C.10008@redhat.com>
	<20060111.000020.25886635.davem@davemloft.net>
	<1136967192.2929.6.camel@laptopd505.fenrus.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@infradead.org>
Date: Wed, 11 Jan 2006 09:13:11 +0100

> > The first suggestion isn't considered ugly, and the best form is:
> > 
> > 	if (ih->frag_off & __constant_htons(IP_OFFSET))
> 
> why this __constant_htons and not just plain htons ??
> htons() gets auto-remapped to that anyway via the builtin "is this a
> constant" thing...... and to be honest htons() is more readable.

You're right.

We use the __constant_*() things for structure initialization
which needs to be compile time.
