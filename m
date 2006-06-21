Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbWFUUeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWFUUeu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 16:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWFUUeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 16:34:50 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16104 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030265AbWFUUet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 16:34:49 -0400
Subject: Re: Memory corruption in 8390.c ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: blp@cs.stanford.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87irmu5qu9.fsf@benpfaff.org>
References: <1150907317.8320.0.camel@alice>
	 <1150909982.15275.100.camel@localhost.localdomain>
	 <87mzc65soy.fsf@benpfaff.org>
	 <1150912459.15275.101.camel@localhost.localdomain>
	 <87irmu5qu9.fsf@benpfaff.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Jun 2006 21:50:14 +0100
Message-Id: <1150923014.15275.124.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-06-21 am 11:03 -0700, ysgrifennodd Ben Pfaff:
> You are saying that this:
>         memset(buf, 0, ETH_ZLEN);
>         memcpy(buf, data, ETH_ZLEN);
> is faster than this?
>         memcpy(buf, data, ETH_ZLEN);
> 

No, you are noticing that the memcpy should be skb->len 8)

Alan

