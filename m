Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319486AbSH3IMn>; Fri, 30 Aug 2002 04:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319482AbSH3IMn>; Fri, 30 Aug 2002 04:12:43 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:51445 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319481AbSH3IMl>;
	Fri, 30 Aug 2002 04:12:41 -0400
From: "David Stevens" <dlstevens@us.ibm.com>
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] anycast support for IPv6, linux-2.5.31
To: Pekka Savola <pekkas@netcore.fi>
Cc: linux-kernel@vger.kernel.org, <linux-net@vger.kernel.org>,
       <netdev@oss.sgi.com>
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OFFA0939E5.1805051F-ON88256C25.002A86A6@boulder.ibm.com>
Date: Fri, 30 Aug 2002 01:16:39 -0700
X-MIMETrack: Serialize by Router on D03NM035/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 08/30/2002 02:16:46 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pekka,

You wrote:

>Before going too much down this path, I think one should write an Internet
>Draft about the proposed API (should be quite short & simple) and see what
>kind of response it has in the relevant working groups.

I don't disagree with that, for informational purposes, but it doesn't
conflict
with the RFC's, which of course don't cover API's, and don't specify any
interface
for anycasting.

However, my primary goal is to get anycasting support with an in-kernel
interface
in 2.5 before the freeze. :-) I used the setsockopt() API for testing, and
left it
in the patch for others to do the same. Though I think it's the right
approach, for
the reasons I mentioned, I'd rather see that portion pulled from the patch
if it's
controversial, than have the in-kernel interface and anycasting proper
delayed over
that.

The one use of anycast I'm aware of right now is for IPv6 mobility, which
needs the in-kernel interface. The
user-level interface is important for future applications, and a
reference-counted setsockopt() interface doesn't
mean we can't also have an ip/ifconfig interface for permanent anycast
addresses, too (the required anycast
addresses in this patch are permanent, for example). So I don't see it as
committing to one choice, but having
in-kernel anycast support (soon) I think is the more important first step.

                                    +-DLS




