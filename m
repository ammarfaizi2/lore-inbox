Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281004AbRKCSS0>; Sat, 3 Nov 2001 13:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281003AbRKCSSS>; Sat, 3 Nov 2001 13:18:18 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:4110 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S281001AbRKCSSF>; Sat, 3 Nov 2001 13:18:05 -0500
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: [khttpd-users] khttpd vs tux
Date: Sat, 3 Nov 2001 18:18:04 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9s1ccs$5cd$2@ncc1701.cistron.net>
In-Reply-To: <20011103162642.A25824@fenrus.demon.nl> <Pine.LNX.4.30.0111031740300.8812-100000@mustard.heime.net>
X-Trace: ncc1701.cistron.net 1004811484 5517 195.64.65.67 (3 Nov 2001 18:18:04 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.30.0111031740300.8812-100000@mustard.heime.net>,
Roy Sigurd Karlsbakk  <roy@karlsbakk.net> wrote:
>> tux is more advanced than khttpd. It's also more intrusive to the kernel as
>> far as core changes are concerned. These changes allow for higher
>> performance, but you'll only notice that if you want to fill a gigabit line
>> or more.....
>
>Are there any good reasons why to run khttpd, then?
>What I need is a server serving something between 50 and 500 concurrent
>clients - each downloading at 4-8Mbps.
>Which one would be best? Anyone have an idea?

Seriously? 500*8 Mbit/sec = 4 Gbit/sec

In that case you need at least 10 boxes, each with a gigabit card,
with loadbalancing through DNS. Each box will do max. 400 mbit/sec
and have 50 clients on it - standard apache will do fine, I think.
Otherwise just add a few boxes.

You will need a Juniper M20 or a Cisco 124xx series with 2xSTM16 (OC64)
or 1x10GigE upload capacity and 10xGigE slots in it. That will cost
as much 100-200 of the Linux boxes so the Linux boxes are the least
of your worries. Not to mention the cost of 4 Gbit/sec of Internet
bandwidth.

Mike.
-- 
"Only two things are infinite, the universe and human stupidity,
 and I'm not sure about the former" -- Albert Einstein.

