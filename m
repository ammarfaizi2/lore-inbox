Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270930AbRHNXD5>; Tue, 14 Aug 2001 19:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270931AbRHNXDr>; Tue, 14 Aug 2001 19:03:47 -0400
Received: from sj-msg-core-4.cisco.com ([171.71.163.10]:11254 "EHLO
	sj-msg-core-4.cisco.com") by vger.kernel.org with ESMTP
	id <S270930AbRHNXDb>; Tue, 14 Aug 2001 19:03:31 -0400
Message-Id: <4.3.2.7.2.20010814155831.04b31220@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 14 Aug 2001 16:01:45 -0700
To: Chris Crowther <chrisc@shad0w.org.uk>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: [PATCH] CDP handler for linux
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108141934130.3283-100000@monolith.shad0w.or
 g.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

g'day,

At 07:47 PM 14/08/2001 +0100, Chris Crowther wrote:
>         I've been working on an addition to the kernel over the past
>couple of days that enables the kernel to interpret CDP (Cisco Discovery
>Protocol) packets which can be transmited by various pieces of Cisco kit.
..

for various devices/developments inside Cisco, we've implemented CDP in 
user-space.

basically all that is required to do that is to hook into the 802.2/SNAP 
stuff that is already in the kernel (net/802) - in my case, i just used 
netlink so as to allow user-space to receive the whole packet and avoid any 
processing in the kernel.

you may want to consider the same.  at least for cisco products, there are 
LOTS of permutations of enabling/disabling CDP on a per-interface-basis and 
what-ip-addresses-to-advertise-in-CDP and 
what-functionality-to-advertise-in-CDP.
most of those kinds of policies are probably outside the scope of what 
logic you would expect in the kernel.

my $0.02 worth,
cheers,

lincoln.


