Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262395AbUK0AuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbUK0AuX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 19:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbUKZXzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 18:55:41 -0500
Received: from zeus.kernel.org ([204.152.189.113]:9413 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263114AbUKZTo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:44:57 -0500
To: linux-kernel@vger.kernel.org
Cc: d507a@cs.aau.dk
Subject: Re: Isolating two network processes on same machine
References: <tv8r7mj1dwr.fsf@homer.cs.aau.dk>
	<8783be6604112412397b46c767@mail.gmail.com>
From: Ole Laursen <olau@cs.aau.dk>
Date: 25 Nov 2004 12:48:10 +0100
In-Reply-To: <8783be6604112412397b46c767@mail.gmail.com>
Message-ID: <tv8fz2yw3np.fsf@homer.cs.aau.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Biro <ross.biro@gmail.com> writes:

> > The problem is that we need to run several instances of our network
> > application on the same test machine since we have too few machines.
> > But when we create two IP addresses on the same machine with
> 
> The easiest solution is probably to have the FreeBSD box DNAT the
> linux boxes so they don't know they are talking to themselves.  Then
> you only need to use 1 ip address per linux box.

Thanks, DNAT seems to be a good solution.

I think we will let the Linux boxes use DNAT to send the packets to
the FreeBSD box and then let that use DNAT to send them back again.
This way we won't have to change our test program, which would be a
bit complicated because the addresses of the peers is an integral part
of the design.

Though it would have been simpler if the kernel supported blindly
forwarding a packet to another host without messing with the IP
destination address, but that does not seem to be the case. It could
have saved us from the double DNAT.

Thanks again,

-- 
Ole Laursen
http://www.cs.aau.dk/~olau/
