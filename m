Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262567AbTCRUnw>; Tue, 18 Mar 2003 15:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262569AbTCRUnw>; Tue, 18 Mar 2003 15:43:52 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:62601 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S262567AbTCRUnu>;
	Tue, 18 Mar 2003 15:43:50 -0500
Subject: Re: eepro100+NAPI failure
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: "Vladimir B. Savkin" <savkin@shade.msu.ru>
Cc: fxzhang@ict.ac.cn, linux-kernel@vger.kernel.org
In-Reply-To: <20030318202728.GA15796@tentacle.sectorb.msk.ru>
References: <20030318202728.GA15796@tentacle.sectorb.msk.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048020884.1521.60.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 18 Mar 2003 21:54:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-18 at 21:27, Vladimir B. Savkin wrote:
> Hi!
> 
> I'm planning to deploy Intel-based fast ethernet NICs on a busy
> router so I decided to try NAPI.

> To test NAPI performance, I've blasted a stream of short packets 
> from another host using pktgen. The bad thing is that receiving host
> stopped responding to packets immediately. The effect is 100%
> reproducable, eventually it comes back though, black-out can last
> from a second to several minutes. Here is what I was able to catch
> after 'ethtool -s eth0 msglvl 0xfff':

I saw the same problem when I tested it a while back, didn't have time
to investigate so my routers are running without NAPI right now :(

> Can anyone help me to make NAPI work? Does anyone even use NAPI
> with eepro100, I guess not many people since the patch is pretty old
> and I could not find it ported to 2.4.21-pre.

I havn't heard of anyone using it. I've understood that the recieve path
in the eepro100 chip can be quite fragile and has to be treated right or
it'll hang... maybe the NAPI patch changes things too much...

Anyway, please let me know if you manage to get it working

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.
