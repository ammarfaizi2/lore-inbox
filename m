Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVDQMc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVDQMc5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 08:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVDQMc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 08:32:57 -0400
Received: from [194.90.79.130] ([194.90.79.130]:14342 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S261310AbVDQMcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 08:32:55 -0400
Subject: Re: More performance for the TCP stack by using additional
	hardware chip on NIC
From: Avi Kivity <avi@argo.co.il>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andreas Hartmann <andihartmann@01019freenet.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1113735452.17394.33.camel@laptopd505.fenrus.org>
References: <d3t63d$3qe$1@pD9F86D3F.dip0.t-ipconnect.de>
	 <1113728880.17394.16.camel@laptopd505.fenrus.org>
	 <1113733753.15803.26.camel@avik.scalemp>
	 <1113735452.17394.33.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Message-Id: <1113741172.15803.55.camel@avik.scalemp>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 17 Apr 2005 15:32:53 +0300
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Apr 2005 12:32:53.0941 (UTC) FILETIME=[93B05E50:01C54349]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-17 at 13:57, Arjan van de Ven wrote:
> > 
> > TOEs can remove the data copy on receive. In some applications (notably
> > storage), where the application does not touch most of the data, this is
> > a significant advantage that cannot be achieved in a software-only
> > solution.
> 
> other solutions can too. Search the archives for posts from Dave Miller
> and Jeff Garzik on these issues. Note that TOEs per se don't do this,
> specific treats of interfaces to TOE *may* allow this. The interesting
> part is that the parts of the interface that would allow this can be
> implemented without TOE (and all the downsides of full TOE such as
> bypassing firewall rules etc etc) just as well.
> 

I see. if you are referring to Willy's trick in the other post, then I
agree. it has still more overhead than full offload, so only
measurements can tell if it is enough (and, of course, need to wait for
the hardware to materialize).


> > a copyless solution is probably necessary to achieve 10Gb/s speeds.
> 
> I've heard the same say abot 100Mbit and 1Gbit. And neither has been
> proven true. Don't get me wrong, avoiding copies is always nice, and on
> sending linux already enables that (depending on the applications
> capabilities). But I personally find it hard to accept that full
> copyless operation is a strict requirement to achieve 10Gb/s.
> 
> What sure will be required to achieve efficient 10Gb/s performance is a
> whole lot of tuning in the network stack and potentially even in the
> tcp/ip layer to allow for bigger buffers etc. But I'm pretty sure that
> effort is underway already or will be soon...
> 

amen.

Avi

