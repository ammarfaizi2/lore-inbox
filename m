Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319432AbSH3Fw2>; Fri, 30 Aug 2002 01:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319437AbSH3Fw2>; Fri, 30 Aug 2002 01:52:28 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:30688 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S319432AbSH3Fw2>;
	Fri, 30 Aug 2002 01:52:28 -0400
Date: Thu, 29 Aug 2002 22:56:51 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200208300556.g7U5up3c025064@napali.hpl.hp.com>
To: linux-kernel@vger.kernel.org
cc: davidm@napali.hpl.hp.com
Subject: page-flags.h pollution?
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-to: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the 2.5.3x kernel, what's the point of defining pte_chain_lock()
and pte_chain_unlock() in page-flags.h?  These two routines make it
impossible to include page-flags.h on it's own, because they require
"struct page" to be defined (and a forward declaration isn't
sufficient either).  This can introduce rather annoying circular
include-file dependencies.

	--david
