Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWFURjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWFURjA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 13:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWFURjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 13:39:00 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47844 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932290AbWFURi4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 13:38:56 -0400
Subject: Re: Memory corruption in 8390.c ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: blp@cs.stanford.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87mzc65soy.fsf@benpfaff.org>
References: <1150907317.8320.0.camel@alice>
	 <1150909982.15275.100.camel@localhost.localdomain>
	 <87mzc65soy.fsf@benpfaff.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Jun 2006 18:54:19 +0100
Message-Id: <1150912459.15275.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-06-21 am 10:23 -0700, ysgrifennodd Ben Pfaff:
> > +		memset(buf, 0, ETH_ZLEN);	/* more efficient than doing just the needed bits */
> > +		memcpy(buf, data, ETH_ZLEN);
> 
> Is this really correct?  It zeros out ETH_ZLEN bytes only to
> immediately copy over all of them again.

When I did it originally I tested with rdtsc and its actually quicker to
let it build the static memset the copy data over it than to do the
extra maths and the variable length loop.

Hence the comment


