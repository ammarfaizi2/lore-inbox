Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293045AbSB0XOZ>; Wed, 27 Feb 2002 18:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293040AbSB0XOU>; Wed, 27 Feb 2002 18:14:20 -0500
Received: from krynn.axis.se ([193.13.178.10]:54508 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S293041AbSB0XOB>;
	Wed, 27 Feb 2002 18:14:01 -0500
Date: Thu, 28 Feb 2002 00:13:53 +0100 (CET)
From: Bjorn Wesen <bjorn.wesen@axis.com>
To: bert hubert <ahu@ds9a.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: What is TCPRenoRecoveryFail ?
In-Reply-To: <20020228000046.A26358@outpost.ds9a.nl>
Message-ID: <Pine.LNX.3.96.1020228000357.2322C-100000@fafner.axis.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2002, bert hubert wrote:
> This dump is somewhat inconclusive. I miss the SYN packets, but I'm

Sorry about that, the dump I got from the one who found the problem didn't
include the SYN's.. I'll dig it up

> how does this continue? I see the linux machine continuing to send data with
> higher sequence numbers, but how does it end? It looks like the linux
> machine never sent anything beyond 11680, relative.

It ends where the dump ends, nothing is sent for the 10 minutes until the
FIN packet. It seems as if Linux fills up the receive window and sits
there, it ignores the ACK's (if they get there).

> To know more, dump at both ends. I really think something in between is
> messing up - either a network adaptor or a ""smart"" network element.

Me too, especially since the dump was made on the windows machine itself..
it just seemed funny that it all works fine when the connection is
restarted (network elements not operating at or above OSI 3 would not know
the difference...). I'll see if I can get a dump "in between".

-BW

