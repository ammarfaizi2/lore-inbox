Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967463AbWLEHFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967463AbWLEHFC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 02:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967391AbWLEHFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 02:05:00 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:35933
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S967131AbWLEHE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 02:04:59 -0500
Date: Mon, 04 Dec 2006 23:05:02 -0800 (PST)
Message-Id: <20061204.230502.35014139.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: krh@redhat.com, linux-kernel@vger.kernel.org, stefanr@s5r6.in-berlin.de
Subject: Re: [PATCH 0/3] New firewire stack
From: David Miller <davem@davemloft.net>
In-Reply-To: <1165297363.29784.54.camel@localhost.localdomain>
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>
	<1165297363.29784.54.camel@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 05 Dec 2006 16:42:42 +1100

>  - It's horribly broken in at least two area :
> 
>  DO NOT USE BITFIELDS FOR DATA ON THE WIRE !!!
> 
>  and
> 
>  Where do you handle endianness ? (no need to shout for
>  that one).
> 
> (Or in general, do not use bitfields period ....)

Yes, this is a show stopper, the endianness and
word-size/endian testing should have been done before
submission.
