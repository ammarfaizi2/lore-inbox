Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbTJOUai (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 16:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264306AbTJOUah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 16:30:37 -0400
Received: from fledge.watson.org ([204.156.12.50]:18954 "EHLO
	fledge.watson.org") by vger.kernel.org with ESMTP id S264305AbTJOUad
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 16:30:33 -0400
Date: Wed, 15 Oct 2003 16:27:35 -0400 (EDT)
From: "Andrew R. Reiter" <arr@watson.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on incoming packets and scheduler
In-Reply-To: <3F8DAA6B.7060609@nortelnetworks.com>
Message-ID: <20031015162634.D56545@fledge.watson.org>
References: <3F8CA55C.1080203@nortelnetworks.com>
 <Pine.LNX.4.56.0310151035480.2144@bigblue.dev.mdolabs.com>
 <3F8D8F3A.5040506@nortelnetworks.com> <Pine.LNX.4.56.0310151133030.2144@bigblue.dev.mdolabs.com>
 <3F8DAA6B.7060609@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Oct 2003, Chris Friesen wrote:

:Davide Libenzi wrote:
:> On Wed, 15 Oct 2003, Chris Friesen wrote:
:
:>>It appears that 2.4.20 fixes this issue, but there is another one
:>>remaining that the latency appears to be dependent on the number of
:>>incoming packets.  See thread "incoming packet latency in 2.4.[18-20]"
:>>for details.  This behaviour doesn't show up in 2.6, and I'm about to
:>>test 2.4.22.
:
:> Are you sure it's not a livelock issue during the burst?
:
:I dunno, you tell me.
:
:The test app simply sits in select() until a packet comes in, then it
:spins on recvmsg() until there are no more messages.  It uses
:SO_TIMESTAMP to find out when the packet got to the kernel, and does a
:gettimeofday() right after the recvmsg(), then calculates the delta for
:each packet and the overall average.
:
:With 2.4.[18-20], the overall average goes up when the number of packets
:goes up.  For 2.6.0-test6, it stays constant.

I would be interested in seeing the test be run with epoll too :)  I
ealize .18 doesn't support this, but how about it for .20?  If not,
perhaps you could shoot over the code and I could test?

Cheers,
Andrew

--
Andrew R. Reiter
arr@watson.org
arr@FreeBSD.org
