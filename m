Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWEZQUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWEZQUc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWEZQUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:20:31 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.27]:44379 "EHLO smtp4.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1751006AbWEZQUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:20:30 -0400
X-ME-UUID: 20060526162029276.439411C003E1@mwinf0407.wanadoo.fr
Date: Fri, 26 May 2006 18:15:18 +0200
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>,
       Alexandre.Bounine@tundra.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>,
       Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
Subject: Re: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerp c pl atform
Message-ID: <20060526161517.GB11778@powerlinux.fr>
References: <1147935734.17679.93.camel@localhost.localdomain> <446C9219.4080300@pobox.com> <446CDE26.8090504@rtr.ca> <20060526083931.GA23938@powerlinux.fr> <4476E964.90509@rtr.ca> <20060526114245.GA32330@powerlinux.fr> <44770065.8070907@rtr.ca> <20060526141535.GA7084@powerlinux.fr> <447722FF.9020202@rtr.ca> <20060526160156.GA11778@powerlinux.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060526160156.GA11778@powerlinux.fr>
User-Agent: Mutt/1.5.9i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 06:01:56PM +0200, Sven Luther wrote:
> > Can you access the disk?  Eg.  hexdump -C /dev/sda
> 
> Trying to partition the disk with parted yielded the last set of debug
> messages, and a : 

Interesting. Using dd, i am able to write some stuff to disk :

dd if=/dev/sda of=/tmp/blah count=1 -> hexdump /tmp/blah yields only 0s.
dd if=/dev/random of=/dev/sda count=4 (count = 4, because /dev/random outputs blocks of 128 bytes)
dd if=/dev/sda of=/tmp/blah count=1 -> hexdump /tmp/blah yield random non-0 content

Trying to write past the first block, seems to freeze the disk or someting, at
least dd doesn't come back without me ctr-c'ing it.

Friendly,

Sven Luther


