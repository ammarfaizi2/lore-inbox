Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422775AbWHAH6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422775AbWHAH6w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 03:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422771AbWHAH6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 03:58:52 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:19081
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1422769AbWHAH6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 03:58:51 -0400
Date: Tue, 01 Aug 2006 00:58:09 -0700 (PDT)
Message-Id: <20060801.005809.102616533.davem@davemloft.net>
To: drepper@redhat.com
Cc: herbert@gondor.apana.org.au, johnpol@2ka.mipt.ru, zach.brown@oracle.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
From: David Miller <davem@davemloft.net>
In-Reply-To: <44CF0866.3000505@redhat.com>
References: <20060731.035716.39159213.davem@davemloft.net>
	<20060731105943.GA26114@gondor.apana.org.au>
	<44CF0866.3000505@redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulrich Drepper <drepper@redhat.com>
Date: Tue, 01 Aug 2006 00:53:10 -0700

> This is the case to keep in mind here.  I thought Zach and the other
> involved in the discussions in Ottawa said this has been shown to be a
> problem and that a ring buffer implementation with something other than
> simple front and back pointers is preferable.

This is part of why I suggested VJ style channel data
structure.  At worst, the cachelines for the entries get
into shared modified state when the remove userland cpu
reads the slot.
