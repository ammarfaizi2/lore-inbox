Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbVLNNSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbVLNNSd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 08:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbVLNNSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 08:18:33 -0500
Received: from relay.axxeo.de ([213.239.199.237]:22417 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S932495AbVLNNSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 08:18:32 -0500
From: Ingo Oeser <netdev@axxeo.de>
Organization: Axxeo GmbH
To: Mitchell Blank Jr <mitch@sfgoth.com>
Subject: Re: [RFC][PATCH 3/3] TCP/IP Critical socket communication mechanism
Date: Wed, 14 Dec 2005 14:18:48 +0100
User-Agent: KMail/1.7.2
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sridhar Samudrala <sri@us.ibm.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <Pine.LNX.4.58.0512140052470.31720@w-sridhar.beaverton.ibm.com> <1134559039.25663.12.camel@localhost.localdomain> <20051214121253.GB23393@gaz.sfgoth.com>
In-Reply-To: <20051214121253.GB23393@gaz.sfgoth.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512141418.48388.netdev@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mitchell Blank Jr wrote:
> Alan Cox wrote:
> > > +#define SK_CRIT_ALLOC(sk, flags) ((sk->sk_allocation & __GFP_CRITICAL) | flags)
> > 
> > Lots of hidden conditional logic on critical paths.
> 
> How expensive is it compared to the allocation itself?

Cost is readability here. You should open code this additional OR


Regards

Ingo Oeser


