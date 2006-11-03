Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753468AbWKCS4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468AbWKCS4X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 13:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753470AbWKCS4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 13:56:23 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:18136 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1753468AbWKCS4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 13:56:22 -0500
Subject: Re: New filesystem for Linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oleg Verych <olecom@flower.upol.cz>
Cc: Andrew Morton <akpm@osdl.org>,
       Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Gabriel C <nix.or.die@googlemail.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20061103171443.GA16912@flower.upol.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
	 <454A71EB.4000201@googlemail.com>
	 <Pine.LNX.4.64.0611030219270.7781@artax.karlin.mff.cuni.cz>
	 <20061102174149.3578062d.akpm@osdl.org>
	 <20061103171443.GA16912@flower.upol.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 03 Nov 2006 19:00:19 +0000
Message-Id: <1162580419.12810.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-11-03 am 17:14 +0000, ysgrifennodd Oleg Verych:
> In gmane.linux.kernel, you wrote:
> []
> > From: Andrew Morton <akpm@osdl.org>
> >
> > As Mikulas points out, (1 << anything) won't be evaluating to zero.
> 
> How about integer overflow ?

That is undefined in C and for some cases will not produce zero but roll
anything%32 bits and the like. If anyone is relying on 1 << foo becoming
zero they need fixing

