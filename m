Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265383AbUEZKPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265383AbUEZKPI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 06:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265409AbUEZKPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 06:15:08 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:45193 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265383AbUEZKPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 06:15:00 -0400
Date: Wed, 26 May 2004 12:14:29 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
       arjanv@redhat.com, benh@kernel.crashing.org, kronos@kronoz.cjb.net,
       linux-kernel@vger.kernel.org
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
Message-ID: <20040526101429.GC12142@wohnheim.fh-wedel.de>
References: <1084488901.3021.116.camel@gaston> <20040513182153.1feb488b.akpm@osdl.org> <20040514094923.GB29106@devserv.devel.redhat.com> <20040514114746.GB23863@wohnheim.fh-wedel.de> <20040514151520.65b31f62.akpm@osdl.org> <20040517233515.GR5414@waste.org> <20040518051745.GK2151@krispykreme> <20040518171136.GC28735@waste.org> <20040518171959.GQ2151@krispykreme> <20040518174734.GE28735@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040518174734.GE28735@waste.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2004 12:47:34 -0500, Matt Mackall wrote:
> 
> Unfortunately, apparently at least objdump for parisc prints hex with
> no leading 0x, and IA64 does something much uglier (as it is wont to
> do), so I'll have to do something a bit more clever here.

Don't waste too much time with it, this is an ugly hack by design
already, for two reasons:

1. It really ought to be part of gcc.  Gcc needs  a
   -Wstack-per-function option that will give a warning whenever the
   stack for any function exceeds some user-defined value.  alloca()
   will exceed any value.
2. We don't care much about the usage per function, but for a complete
   code path.  An expanded checker to do this already exists, I'm
   merely not allowed to give it to anyone.  Lawyers.

Apart from that, go ahead and have fun!

Jörn

-- 
Data expands to fill the space available for storage.
-- Parkinson's Law
