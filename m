Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWFMXBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWFMXBr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 19:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWFMXBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 19:01:47 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:55988
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751175AbWFMXBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 19:01:46 -0400
Date: Tue, 13 Jun 2006 16:01:52 -0700 (PDT)
Message-Id: <20060613.160152.84363218.davem@davemloft.net>
To: rick.jones2@hp.com
Cc: lkml@rtr.ca, jheffner@psc.edu, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.17: networking bug??
From: David Miller <davem@davemloft.net>
In-Reply-To: <448F3EF5.50701@hp.com>
References: <448F32E1.8080002@rtr.ca>
	<20060613.152301.26928146.davem@davemloft.net>
	<448F3EF5.50701@hp.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rick Jones <rick.jones2@hp.com>
Date: Tue, 13 Jun 2006 15:40:53 -0700

> > One final word about window sizes.  If you have a connection whose
> > bandwidth-delay-product needs an N byte buffer to fill, you actually
> > have to have an "N * 2" sized buffer available in order for fast
> > retransmit to work.
> 
> Is that as important in the presence of SACK?

The consern is identical, SACK or not.

The only difference SACK introduces for fast retransmit is that we
know with more certainty which holes need to be filled and thus which
packets to fast retransmit.
