Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272128AbTHDTbP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 15:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272166AbTHDTbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 15:31:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15234 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S272128AbTHDTbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 15:31:12 -0400
Date: Mon, 4 Aug 2003 12:26:32 -0700
From: "David S. Miller" <davem@redhat.com>
To: Werner Almesberger <werner@almesberger.net>
Cc: ebiederm@xmission.com, jgarzik@pobox.com, niv@us.ibm.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: TOE brain dump
Message-Id: <20030804122632.65ba2122.davem@redhat.com>
In-Reply-To: <20030804162433.L5798@almesberger.net>
References: <20030802140444.E5798@almesberger.net>
	<3F2BF5C7.90400@us.ibm.com>
	<3F2C0C44.6020002@pobox.com>
	<20030802184901.G5798@almesberger.net>
	<m1fzkiwnru.fsf@frodo.biederman.org>
	<20030804162433.L5798@almesberger.net>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003 16:24:33 -0300
Werner Almesberger <werner@almesberger.net> wrote:

> Eric W. Biederman wrote:
> > There is one place in low latency communications that I can think
> > of where TCP/IP is not the proper solution.  For low latency
> > communication the checksum is at the wrong end of the packet.
> 
> That's one of the few things ATM's AAL5 got right.

Let's recall how long the IFF_TRAILERS hack from BSD :-)

> But in the end, I think it doesn't really matter.

I tend to agree on this one.

And on the transmit side if you have more than 1 pending TX frame, you
can always be prefetching the next one into the fifo so that by the
time the medium is ready all the checksum bits have been done.

In fact I'd be surprised if current generation 1g/10g cards are not
doing something like this.
