Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVCUIZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVCUIZq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 03:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVCUIYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 03:24:42 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:51840 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261696AbVCUIYL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 03:24:11 -0500
Subject: Re: [patch 1/2] fork_connector: add a fork connector
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Jay Lan <jlan@engr.sgi.com>,
       Erich Focht <efocht@hpce.nec.com>, Ram <linuxram@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>, Greg KH <greg@kroah.com>
In-Reply-To: <200503171405.55095.jbarnes@engr.sgi.com>
References: <1111050243.306.107.camel@frecb000711.frec.bull.fr>
	 <200503170856.57893.jbarnes@engr.sgi.com>
	 <20050318003857.4600af78@zanzibar.2ka.mipt.ru>
	 <200503171405.55095.jbarnes@engr.sgi.com>
Date: Mon, 21 Mar 2005 09:23:51 +0100
Message-Id: <1111393431.8349.3.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/03/2005 09:33:26,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/03/2005 09:33:35,
	Serialize complete at 21/03/2005 09:33:35
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-17 at 14:05 -0800, Jesse Barnes wrote:
> On Thursday, March 17, 2005 1:38 pm, Evgeniy Polyakov wrote:
> > The most significant part there - is requirement to store
> > u32 seq in each CPU's cache and thus flush cacheline +
> > invalidate/get from mem on each other cpus
> > each time it is accessed, which is a big price.
> 
> Same thing has to happen with the lock.  To put it simply, writing global 
> variables from multiple CPUs with anything other than very low frequency is 
> bad.
> 
> > It is totally Guillaume's work - so he decides,
> > I would recomend per cpu counters and processor's
> > id in each message.
> > And of course userspace should take care of misordered
> > messages.
> > I personally prefer such mechanism.
> 
> Yep, I agree.  Hopefully Guillaume will too :)

Sure, I agree and I will implement the per cpu counters solution with a
processor id in each message. 

Thank you very much Jesse and Evgeniy for your great help,
Best regards,

Guillaume

