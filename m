Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272922AbRIHA1U>; Fri, 7 Sep 2001 20:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272923AbRIHA1A>; Fri, 7 Sep 2001 20:27:00 -0400
Received: from 65-45-81-178.customer.algx.net ([65.45.81.178]:40946 "EHLO
	postbox.aslab.com") by vger.kernel.org with ESMTP
	id <S272922AbRIHA07>; Fri, 7 Sep 2001 20:26:59 -0400
Date: Fri, 7 Sep 2001 17:13:43 -0700 (PDT)
From: "John D. Kim" <johnkim@aslab.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4 kernel PCMCIA and IP kernel level autoconf ordering
Message-ID: <Pine.LNX.4.31.0109071706340.10804-100000@postbox.aslab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to boot a laptop with root fs over NFS.  We have a system that
works well for desktop systems, but I'd also like for it to work with
pcmcia ethernet card.  So I'm using a 2.4.9-ac8 kernel, with the necessary
PCMCIA stuff built into the kernel as well as the DHCP and BOOTP support
under kernel(CONFIG_IP_PNP).

The problem is that the kernel tries the DHCP stuff first, loading the
PCMCIA stuff second, one of two steps after the DHCP step.  And since
there's no ethernet detected at the time to send out the DHCP request, it
fails.

Is there any way to change the loading order around so that it would load
the PCMCIA stuff first, then the DHCP stuff?

John Kim


