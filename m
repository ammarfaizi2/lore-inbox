Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUCFNNo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 08:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbUCFNNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 08:13:44 -0500
Received: from spectre.fbab.net ([212.214.165.139]:11656 "HELO mail2.fbab.net")
	by vger.kernel.org with SMTP id S261606AbUCFNNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 08:13:43 -0500
Message-ID: <4049CE78.7040607@fbab.net>
Date: Sat, 06 Mar 2004 14:13:28 +0100
From: "Magnus Naeslund(t)" <mag@fbab.net>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Magnus Naeslund(t)" <mag@fbab.net>
CC: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
References: <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143425.GA11604@elte.hu> <20040305145947.GA4922@dualathlon.random> <20040305150225.GA13237@elte.hu> <20040305201139.GA7254@mail.shareable.org> <20040306051256.GA9909@mail.shareable.org> <4049CA99.4020002@fbab.net>
In-Reply-To: <4049CA99.4020002@fbab.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Naeslund(t) wrote:
> 
> But isn't this kind of code a known buggy way of implementing timeouts?
> Shouldn't it be like:
> 
> time_t x = time(0);
> do {
>   ...
> } while (time(0) - x >= TIMEOUT_IN_SECONDS);

I meant:
  } while (time(0) - x < TIMEOUT_IN_SECONDS);

Also if time_t is signed, that needs to be taken care of.

Magnus - butterfingers

