Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266179AbUFIVLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266179AbUFIVLW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 17:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266180AbUFIVLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 17:11:21 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:42122 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S266179AbUFIVLJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 17:11:09 -0400
Message-ID: <40C77C70.5070409@tmr.com>
Date: Wed, 09 Jun 2004 17:09:04 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>
CC: "David S. Miller" <davem@redhat.com>, jgarzik@pobox.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] ethtool semantics
References: <20040607212804.GA17012@k3.hellgate.ch> <20040607145723.41da5783.davem@redhat.com> <20040608210809.GA10542@k3.hellgate.ch>
In-Reply-To: <20040608210809.GA10542@k3.hellgate.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi wrote:
> On Mon, 07 Jun 2004 14:57:23 -0700, David S. Miller wrote:
> 
>>On Mon, 7 Jun 2004 23:28:04 +0200
>>Roger Luethi <rl@hellgate.ch> wrote:
>>
>>
>>>What is the correct response if a user passes ethtool speed or duplex
>>>arguments while autoneg is on? Some possible answers are:
>>>
> 
> [...]
> 
>>speed and duplex fields should be silently ignored in this case
> 
> 
> It may not matter much because few people care about forced media these
> days. And it is debatable whether trying to guess the users intention
> is a good idea (we lack means for users to manipulate autoneg results
> via advertisted values but that's no big deal).

It does sometimes matter, because even these days we sometimes see a 
case where a brand name switch (like Cisco) and a brand name card 
(Intel, 3COM) negotiate but just don't "work right" later. In those 
cases forcing on both ends or just the NIC end results in a fully 
functional connection.

We usually do this with module parameters, but do use ethtool (or 
mii-tool) on occasion.

> 
> However, "silently ignoring" strikes me as a very poor choice, in
> stark contrast to Unix/Linux tradition. A user issues a command which
> cannot be executed and gets the same response that is used to indicate
> success!? What school of user interface design is that? How is that
> not confusing users? </rant>

Yah.

Seeing this happen while autonegotiation is in progress is a small and 
unlikely window of course!

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
