Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751969AbWCFRo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbWCFRo2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 12:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbWCFRo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 12:44:28 -0500
Received: from mail.axxeo.de ([82.100.226.146]:37308 "EHLO mail.axxeo.de")
	by vger.kernel.org with ESMTP id S1751380AbWCFRo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 12:44:27 -0500
From: Ingo Oeser <netdev@axxeo.de>
Organization: Axxeo GmbH
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [PATCH 0/8] Intel I/O Acceleration Technology (I/OAT)
Date: Mon, 6 Mar 2006 18:44:07 +0100
User-Agent: KMail/1.7.2
Cc: "David S. Miller" <davem@davemloft.net>, jengelh@linux01.gwdg.de,
       christopher.leech@intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
References: <20060303214036.11908.10499.stgit@gitlost.site> <20060304.134144.122314124.davem@davemloft.net> <20060305014324.GA20026@2ka.mipt.ru>
In-Reply-To: <20060305014324.GA20026@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603061844.07439.netdev@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> On Sat, Mar 04, 2006 at 01:41:44PM -0800, David S. Miller (davem@davemloft.net) wrote:
> > From: Jan Engelhardt <jengelh@linux01.gwdg.de>
> > Date: Sat, 4 Mar 2006 19:46:22 +0100 (MET)
> > 
> > > Does this buy the normal standard desktop user anything?
> > 
> > Absolutely, it optimizes end-node performance.
> 
> It really depends on how it is used.
> According to investigation made for kevent based FS AIO reading,
> get_user_pages() performange graph looks like sqrt() function

Hmm, so I should resurrect my user page table walker abstraction?

There I would hand each page to a "recording" function, which
can drop the page from the collection or coalesce it in the collector
if your scatter gather implementation allows it.

Regards

Ingo Oeser
