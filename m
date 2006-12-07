Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163490AbWLGWLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163490AbWLGWLa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 17:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163489AbWLGWL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 17:11:29 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:41506
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1163456AbWLGWL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 17:11:28 -0500
Date: Thu, 07 Dec 2006 14:11:40 -0800 (PST)
Message-Id: <20061207.141140.39644636.davem@davemloft.net>
To: dhowells@redhat.com
Cc: James.Bottomley@SteelEye.com, akpm@osdl.org, torvalds@osdl.org,
       davem@davemloft.com, wli@holomorphy.com, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/3] WorkStruct: Use direct assignment rather than
 cmpxchg() 
From: David Miller <davem@davemloft.net>
In-Reply-To: <10660.1165526163@redhat.com>
References: <20061207153143.28408.7274.stgit@warthog.cambridge.redhat.com>
	<639.1165521999@redhat.com>
	<10660.1165526163@redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Thu, 07 Dec 2006 21:16:03 +0000

> I don't know that sparc32 can do conditional instructions for
> example.  If we force this assumption it becomes a potential
> limitation on the archs we can support.  OTOH, it may be that every
> arch that supports SMP and has to emulate bitops with spinlocks also
> supports conditional stores; but I don't know that.

Sparc32 has normal branches but no conditional instruction execution.
