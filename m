Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbVI2PrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVI2PrZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 11:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbVI2PrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 11:47:25 -0400
Received: from [81.2.110.250] ([81.2.110.250]:29582 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932165AbVI2PrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 11:47:24 -0400
Subject: Re: Strange disk corruption with Linux >= 2.6.13
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: vherva@vianova.fi
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050929062937.GY24719@viasys.com>
References: <20050927111038.GA22172@ime.usp.br>
	 <20050928084330.GC24760@viasys.com>
	 <1127949809.26686.14.camel@localhost.localdomain>
	 <20050929062937.GY24719@viasys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 29 Sep 2005 17:14:44 +0100
Message-Id: <1128010484.5774.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-09-29 at 09:29 +0300, Ville Herva wrote:
> On Thu, Sep 29, 2005 at 12:23:28AM +0100, you [Alan Cox] wrote:
> > On Mer, 2005-09-28 at 11:43 +0300, Ville Herva wrote:
> > > I NEVER got the board stable, and ended up ditching it.
> > > 
> > > It seemed to be a KT133 Northbridge DMA issue. My impression is that KT133
> > > is utter crap period.
> > 
> > It was a FIFO bug, but the kernel knows about it and it should handle
> > this correctly. 
> 
> Interesting. Since which version?

Some fixes went in early 2.4 and they got refined later on. See the
function quirk_vialatency). There is a brief summary at the first URL
listed still. Essentially the chip has a flaw where it can lose a
transfer.

If people see this behaviour on a KT133 can you please check the quirk
is being run and displaying

   printk(KERN_INFO "Applying VIA southbridge workaround.\n");

