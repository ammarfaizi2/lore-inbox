Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264391AbTLaMZq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 07:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbTLaMZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 07:25:45 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:45289 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S264391AbTLaMZn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 07:25:43 -0500
Date: Wed, 31 Dec 2003 07:21:55 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-mm2] e100 driver hangs after period of moderate receive load
Message-ID: <20031231122155.GA13323@gnu.org>
References: <20031231110209.GA9858@gnu.org> <3FF2BCDE.5010302@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF2BCDE.5010302@pobox.com>
User-Agent: Mutt/1.3.28i
From: Lennert Buytenhek <buytenh@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 07:11:10AM -0500, Jeff Garzik wrote:

> >After banging on an e100 card for about ten minutes with a ~60kpps stream,
> >the interface stops receiving packets.  Interrupts come in once every few
> >seconds (from /proc/interrupts), but no packets are received anymore at 
> >all.
> >Lots of slab corruption messages in the syslog that were generated during
> >that packet stream (see other email I sent.)  Stopping the packet stream
> >still leaves the interface unusable.  'ifconfig eth1 down ; ifconfig eth1 
> >up'
> >seems to fix things.
> 
> Is NAPI enabled for this driver?  The interrupt behavior seems normal 
> for NAPI, but certainly the rest of the behavior does not...

Yes, NAPI was indeed enabled.

I 'went back' to 2.6.1-rc1 and that seems fine now.  Any patches you want
me to try on top of 2.6.0-mm2?


--L
