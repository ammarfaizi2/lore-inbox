Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317689AbSGKA05>; Wed, 10 Jul 2002 20:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317690AbSGKA04>; Wed, 10 Jul 2002 20:26:56 -0400
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:5018 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S317689AbSGKA04>; Wed, 10 Jul 2002 20:26:56 -0400
Message-Id: <5.1.0.14.2.20020711102614.0209de60@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 11 Jul 2002 10:28:41 +1000
To: Andrew Morton <akpm@zip.com.au>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: HZ, preferably as small as possible
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       Linux <linux-kernel@vger.kernel.org>
In-Reply-To: <3D2CA6E3.CB5BC420@zip.com.au>
References: <59885C5E3098D511AD690002A5072D3C02AB7F88@orsmsx111.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:28 PM 10/07/2002 -0700, Andrew Morton wrote:
> > But on the other hand, increasing HZ has perf/latency benefits, yes? Have
> > these been quantified?
>
>Not that I'm aware of.  And I'd regard any such claims with some
>scepticism.

for one, i'm using a modified version of the network FIFO queue discipline 
to inject "delay" and "drop", similar to what ippipe can do on FreeBSD.
given i'm using a kernel timer for this, HZ >= 1000 is essential for <1.5 
millisecond accuracy.

perhaps we really need a high-speed timer mechanism for parts of the kernel 
that require it (or a highly-accurate single-fire timer)?


cheers,

lincoln.

