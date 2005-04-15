Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVDOQPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVDOQPu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 12:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbVDOQPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 12:15:50 -0400
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34]:13071 "EHLO
	smtp-vbr14.xs4all.nl") by vger.kernel.org with ESMTP
	id S261846AbVDOQPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 12:15:39 -0400
Subject: Re: Adaptec 2010S i2o + x86_64 doesn't work
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Markus.Lidel@shadowconnect.com, miquels@cistron.nl
In-Reply-To: <1113576775.11116.17.camel@localhost.localdomain>
References: <20050413160352.GA12841@xs4all.net>
	 <1113576775.11116.17.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 15 Apr 2005 18:15:22 +0200
Message-Id: <1113581722.14421.15.camel@zahadum.xs4all.nl>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-15 at 15:52 +0100, Alan Cox wrote:
> On Mer, 2005-04-13 at 17:03, Miquel van Smoorenburg wrote:
> > I have a supermicro dual xeon em64t system, X6DH8-XG2 motherboard,
> > 4 GB RAM, with an Adaptec zero raid 2010S i2o controller. In 32
> > bits mode it runs fine, both with the dpt_i2o driver and the
> > generic i2o_block driver using kernel 2.6.11.6.
> 
> Does it work if you drop the box to 2Gbytes ?

I tried 2.6.9 with 4GB and it didn't make any difference.

However, I removed 2 GB from the box as Alan sugggested and now the box
comes up just fine with a 64-bit 2.6.11.6 kernel! I've put the 4GB back,
and booted with the kernel "mem=2048" command line option - that also
works, the i2o_block driver sees the adaptec controller just fine.

And I just booted it with "mem=3840M" and that works too.

So the problem appears to be 4 GB memory in 64 bit mode, on this box.

Mike.

