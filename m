Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbVLSTsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbVLSTsB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 14:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbVLSTsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 14:48:01 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:23938 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964915AbVLSTsA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 14:48:00 -0500
Subject: Re: [Bug] mlockall() not working properly in 2.6.x
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zan Lynx <zlynx@acm.org>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Marc-Jano Knopp <pub_ml_lkml@marc-jano.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1135017515.13318.11.camel@localhost>
References: <20051218212123.GC4029@mjk.myfqdn.de>
	 <20051219022108.307e68b8.akpm@osdl.org>
	 <20051219114231.GA2830@mjk.myfqdn.de>  <20051219172735.GL13985@lug-owl.de>
	 <1135014451.6051.23.camel@localhost.localdomain>
	 <1135017515.13318.11.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Dec 2005 19:48:20 +0000
Message-Id: <1135021701.6051.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-12-19 at 11:38 -0700, Zan Lynx wrote:
> How about clearing MCL_FUTURE on fork but allow exec to inherit it?
> That way a parent process could fork, mlockall in the child and exec a
> memlocked child.  A regular fork,exec by a memlocked parent would not
> create a memlocked child.
> 
> Seems less messy than a new flag, while keeping the benefits.

The behaviour of MCL_FUTURE is standards defined so we don't get to
change it. The behaviour of an added flag is up to us.

