Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261406AbTCTHY7>; Thu, 20 Mar 2003 02:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbTCTHY7>; Thu, 20 Mar 2003 02:24:59 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:20940 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261406AbTCTHY6>; Thu, 20 Mar 2003 02:24:58 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] anycast support for IPv6, updated to 2.5.44
To: "David S. Miller" <davem@redhat.com>
Cc: yoshfuji@wide.ad.jp, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF4D6C9027.2F431095-ON88256CEF.002804BF@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Thu, 20 Mar 2003 00:34:41 -0700
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.0 [IBM]|December 16, 2002) at
 03/20/2003 00:34:43
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Yoshifuji,
      I created the multicast-like API because, aside from the in-kernel
use, there was no way to use anycasting otherwise, and I believe for at
least the high-availability case, it doesn't make any sense to treat it
like a unicast address. An exited DNS server program with the server
machine still up will in fact deny service to clients that might otherwise
find a working server if the "permanent" address model were not there. With
a multicast-like interface at least available, programs have the choice of
tying the anycast address to whether or not the service that needs it is
running.
      That said, there's no reason why you can't have both, and that's
straightforward with the code (but not implemented). I think it's too early
to be concerned with compatibility since there is no alternative
non-permanent anycast address API. If Linux has an API to do something that
can't be done at all on other systems, there clearly isn't a portability
issue.

                        +-DLS

