Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291375AbSBGW3r>; Thu, 7 Feb 2002 17:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291378AbSBGW3i>; Thu, 7 Feb 2002 17:29:38 -0500
Received: from gw-yyz.somanetworks.com ([216.126.67.39]:28640 "EHLO
	somanetworks.com") by vger.kernel.org with ESMTP id <S291375AbSBGW3e>;
	Thu, 7 Feb 2002 17:29:34 -0500
Date: Thu, 7 Feb 2002 17:29:26 -0500
From: Mark Frazer <mark@somanetworks.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: root@chaos.analogic.com, "Perches, Joe" <joe.perches@spirentcom.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Re: want opinions on possible glitch in 2.4 network error reporti ng
Message-ID: <20020207172926.A22693@somanetworks.com>
In-Reply-To: <Pine.LNX.3.95.1020207151325.10014A-100000@chaos.analogic.com> <3C62EC67.FCB9958A@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C62EC67.FCB9958A@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Thu, Feb 07, 2002 at 04:06:47PM -0500
X-Message-Flag: Lookout!
Organization: Detectable, well, not really
X-Bender-1: In the event of an emergency, my ass can be used as a flotation
X-Bender-2: device.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen <cfriesen@nortelnetworks.com> [02/02/07 16:04]:
> under our control.  It seems to me to be logical to block the sender
> until the congestion goes away, or return with an error code if the
> sender is non-blocking.  This may not play nice with the current kernel
> networking code (qdisc and all that) but doesn't it seem like a good
> idea in principle?

If not, it is then possible for a user on a fast machine to hammer the
network interfaces with UDP packets as some sort of denial of service
attack?

Blocking all senders when the qdisc is full and round-robin'ing among
the blocked would prevent this particular attack.
