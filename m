Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264456AbRFOR4m>; Fri, 15 Jun 2001 13:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264436AbRFOR4c>; Fri, 15 Jun 2001 13:56:32 -0400
Received: from laird.ocp.internap.com ([64.94.114.35]:2572 "EHLO
	laird.ocp.internap.com") by vger.kernel.org with ESMTP
	id <S264456AbRFOR4S>; Fri, 15 Jun 2001 13:56:18 -0400
Date: Fri, 15 Jun 2001 10:56:06 -0700 (PDT)
From: Scott Laird <laird@internap.com>
X-X-Sender: <laird@laird.ocp.internap.com>
To: <chuckw@altaserv.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.2.19 -> 80% Packet Loss 
In-Reply-To: <Pine.LNX.4.33.0106150711350.20189-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0106151054040.2642-100000@laird.ocp.internap.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Fri, 15 Jun 2001 chuckw@altaserv.net wrote:
>
> > You can fix this by upping the socket buffer that ping asks for (look
> > for setsockopt( ... SO_RCVBUF ...)) and then tuning the kernel to
> > allow larger socket buffers.  The file to fiddle with is
> > /proc/sys/net/core/rmem_max.
>
> Currently it is set to 65535. I doubled it several times and each time saw
> no change when I sent it a ping flood with packet size 64590 or higher.
> What sort of magnitude were you thinking?

Did you change both /proc/sys/net/core/rmem_max *and* ping's setsockopt?
Do an strace on ping and see what's happening.


Scott

