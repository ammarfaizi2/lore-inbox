Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264038AbUDVNlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264038AbUDVNlh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 09:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264037AbUDVNlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 09:41:36 -0400
Received: from chaos.analogic.com ([204.178.40.224]:41856 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264035AbUDVNl2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 09:41:28 -0400
Date: Thu, 22 Apr 2004 09:42:58 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Willy Tarreau <w@w.ods.org>
cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
In-Reply-To: <20040422131704.GA6839@alpha.home.local>
Message-ID: <Pine.LNX.4.53.0404220929500.8745@chaos>
References: <XFMail.20040422102359.pochini@shiny.it> <Pine.LNX.4.53.0404220734330.8039@chaos>
 <20040422131704.GA6839@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2004, Willy Tarreau wrote:

> On Thu, Apr 22, 2004 at 07:35:54AM -0400, Richard B. Johnson wrote:
>
> > Has anybody checked to see what Linux does if it receives a
> > RST to the broadcast address? It would be a shame if all
> > connections were dropped!
>
> I don't see how this would be possible : a TCP packet is matched *only* if
> it refers to a valid session. If you have no session established from/to the
> broadcast address, there's no possibility that an RST targetted at this
> address
> terminates anything, even if the ports are OK.
>
> Cheers,
> Willy
>

If course it's possible. Remember the trick to blue-screen W$, just
send a fragmented packet with a large length, then never send the
rest. There are lots of things that can happen when control
data goes to the broadcast address. Ping the broadcast address and
observe. If you have any W$/2000/prof machines on your network that
don't have service-pack 2 or later installed, just syn-flood the
broadcast address. So I  wonder how well the corner cases have been
checked. Of course you can't "connect" to a host using the broadcast
address, unless some code runs off the end of a switch statement
unchecked.

Hopefully invalid packets just get dropped on the floor. However,
history shows otherwise. Linux has a habit of loudly complaining
about invalid packets or protocol violations. The result being
a log full of messages leading to a full file-system. Fortunately
one can turn off many using the /proc/sys/net/ipv4 interface.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


