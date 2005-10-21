Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965072AbVJUSUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbVJUSUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 14:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbVJUSUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 14:20:14 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:14474 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S965072AbVJUSUM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 14:20:12 -0400
Date: Fri, 21 Oct 2005 12:20:09 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Christoph Hellwig <hch@lst.de>, Jeff Garzik <jgarzik@pobox.com>,
       andrew.patterson@hp.com, "Moore, Eric Dean" <Eric.Moore@lsil.com>,
       jejb@steeleye.com, linux-scsi@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached PHYs)
Message-ID: <20051021182009.GA3364@parisc-linux.org>
References: <91888D455306F94EBD4D168954A9457C048F0E34@nacos172.co.lsil.com> <20051020160155.GA14296@lst.de> <4357CB03.4020400@adaptec.com> <20051020170330.GA16458@lst.de> <4357F7DE.7050004@adaptec.com> <1129852879.30258.137.camel@bluto.andrew> <43583A53.2090904@pobox.com> <435929FD.4070304@adaptec.com> <20051021180455.GA6834@lst.de> <43592FA1.8000206@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43592FA1.8000206@adaptec.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2005 at 02:12:49PM -0400, Luben Tuikov wrote:
> > That beeing said I tried this approach.  It looks pretty cool when you
> > think about it, but the block layer is quite a bit too heavyweight for
> > queueing up a few SMP requests, and we need to carry too much useless
> > code around for it.
> 
> That's the last reason not to implement SMP as a block device.
> But this is good that you tried it and it "flopped".  This way
> people will stop repeating "SMP... block device".

Block layer != Block device.

Nobody wants to implement SMP as a block device.

The question is whether the SMP interface should be implemented as part
of the block layer.
