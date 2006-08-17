Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWHQATA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWHQATA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 20:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWHQATA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 20:19:00 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:12507 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932153AbWHQAS7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 20:18:59 -0400
Subject: Re: What determines which interrupts are shared under Linux?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Lord <liml@rtr.ca>
Cc: Roger Heflin <rheflin@atipa.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
In-Reply-To: <44E3A22F.20400@rtr.ca>
References: <44E1D760.6070600@atipa.com>
	 <1155654379.24077.286.camel@localhost.localdomain>
	 <44E1E719.6020005@atipa.com>
	 <1155657316.24077.293.camel@localhost.localdomain>
	 <44E208AD.8060505@atipa.com>  <44E3A22F.20400@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Aug 2006 01:39:40 +0100
Message-Id: <1155775180.15195.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-16 am 18:54 -0400, ysgrifennodd Mark Lord:
> Roger Heflin wrote:
> >
> > It looks like the older DMA recovery code never works on this chipset,
> > once it goes into DMA recovery it never comes out of it. 

DMA recovery is fairly broken in drivers/ide especially if it tries to
change mode. libata does not have this problem and I have no plans to
even try and fix the drivers/ide code for this issue as its a major
piece of work.

