Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbUCaQZT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 11:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbUCaQZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 11:25:19 -0500
Received: from dh132.citi.umich.edu ([141.211.133.132]:387 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S261804AbUCaQZM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 11:25:12 -0500
Subject: Re: kernel 2.6.4 and nfs lockd.udpport?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jamie Lokier <jamie@shareable.org>
Cc: Jan Kesten <rwe.piller@the-hidden-realm.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20040331145711.GB18990@mail.shareable.org>
References: <200403290958.i2T9w2fJ029554@mail.bytecamp.net>
	 <1080587948.2410.68.camel@lade.trondhjem.org>
	 <20040331145711.GB18990@mail.shareable.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1080750306.4194.7.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 31 Mar 2004 11:25:06 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-31 at 09:57, Jamie Lokier wrote:

> The module parameters "nlm_udpport" and "nlm_tcpport" _do_ work -- I
> use them with my firewall.
> 
> For some reason, because modules don't need #ifdef MODULE any more, I
> thought module_param*() entries would be automatically available as
> boot parameters.  Silly me, that would be too obvious.

module_param*() ought indeed to suffice.

AFAICS the only problem here is that Documentation/kernel-parameters.txt
still lists lockd.udpport and lockd.tcpport instead of the new names
lockd.nlm_udpport and lockd.nlm_udpport.
There is also lockd.nlm_grace_period, and lockd.nlm_timeout, both of
which need to be added to the same list...

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>
