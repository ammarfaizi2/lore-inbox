Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVCQWHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVCQWHs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 17:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVCQWHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 17:07:48 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:43673 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261248AbVCQWHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 17:07:43 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: johnpol@2ka.mipt.ru
Subject: Re: [patch 1/2] fork_connector: add a fork connector
Date: Thu, 17 Mar 2005 14:05:54 -0800
User-Agent: KMail/1.7.2
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Jay Lan <jlan@engr.sgi.com>, Erich Focht <efocht@hpce.nec.com>,
       Ram <linuxram@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>, Greg KH <greg@kroah.com>
References: <1111050243.306.107.camel@frecb000711.frec.bull.fr> <200503170856.57893.jbarnes@engr.sgi.com> <20050318003857.4600af78@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050318003857.4600af78@zanzibar.2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503171405.55095.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 17, 2005 1:38 pm, Evgeniy Polyakov wrote:
> The most significant part there - is requirement to store
> u32 seq in each CPU's cache and thus flush cacheline +
> invalidate/get from mem on each other cpus
> each time it is accessed, which is a big price.

Same thing has to happen with the lock.  To put it simply, writing global 
variables from multiple CPUs with anything other than very low frequency is 
bad.

> It is totally Guillaume's work - so he decides,
> I would recomend per cpu counters and processor's
> id in each message.
> And of course userspace should take care of misordered
> messages.
> I personally prefer such mechanism.

Yep, I agree.  Hopefully Guillaume will too :)

Jesse
