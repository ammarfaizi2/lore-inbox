Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261829AbSKMNzP>; Wed, 13 Nov 2002 08:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbSKMNzP>; Wed, 13 Nov 2002 08:55:15 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:38569 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261829AbSKMNzO>; Wed, 13 Nov 2002 08:55:14 -0500
Subject: Re: Users locking memory using futexes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Mark Mielke'" <mark@mark.mielke.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021113071630.376412C118@lists.samba.org>
References: <20021113071630.376412C118@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Nov 2002 14:27:03 +0000
Message-Id: <1037197623.11996.63.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-12 at 18:13, Rusty Russell wrote:
> It's bounded by one page per fd.  If you want better than that, then
> yes we'll need to thihk harder.

one page per fd is "unbounded" to all intents and purposes. Doing the
page accounting per user doesnt look too scary if we ignore stuff like
page tables for a first cut.

