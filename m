Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSFJMFm>; Mon, 10 Jun 2002 08:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311871AbSFJMFl>; Mon, 10 Jun 2002 08:05:41 -0400
Received: from sj-msg-core-4.cisco.com ([171.71.163.10]:29695 "EHLO
	sj-msg-core-4.cisco.com") by vger.kernel.org with ESMTP
	id <S311752AbSFJMFk>; Mon, 10 Jun 2002 08:05:40 -0400
Message-Id: <5.1.0.14.2.20020610220015.040aff60@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 10 Jun 2002 22:03:25 +1000
To: "David S. Miller" <davem@redhat.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: RFC: per-socket statistics on received/dropped packets
Cc: greearb@candelatech.com, mark@mark.mielke.cc, cfriesen@nortelnetworks.com,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20020609.213440.04716391.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:34 PM 9/06/2002 -0700, David S. Miller wrote:
>Every argument I hear is one out of lazyness.  And that is not a
>reason to add something.  Simply put, I don't want to add all of this
>per-socket counter bumping that only, at best, 1 tenth of 1 percent
>of people will use.  This means that the rest of the world eats the
>overhead just for this small group that actually uses it.

would you be willing to accept a patch that enables per-socket accounting 
with a CONFIG_ option?

to my mind, i can see a number of perfectly valid scenarios.
one is for streaming-media applications which could use retransmissions as 
an indication to buffer more data and/or switch to a different bitrate.

another is for a http proxy which has multiple outgoing interfaces which 
are multihomed via different providers (and some via simplex satellite).
retransmissions woud be a nice metric to use for determining the weightings 
between using different interfaces.


cheers,

lincoln.

