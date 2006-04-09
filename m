Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWDIMIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWDIMIw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 08:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWDIMIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 08:08:52 -0400
Received: from galaxy.systems.pipex.net ([62.241.162.31]:18594 "EHLO
	galaxy.systems.pipex.net") by vger.kernel.org with ESMTP
	id S1750734AbWDIMIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 08:08:51 -0400
Message-ID: <4438F952.5040802@dsl.pipex.com>
Date: Sun, 09 Apr 2006 13:08:50 +0100
From: Andy Furniss <andy.furniss@dsl.pipex.com>
Reply-To: andy.furniss@dsl.pipex.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-gb, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
Cc: michal.k.k.piotrowski@gmail.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Linux v2.6.16-rc6
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org>	<6bffcb0e0603111751i1ed30794s@mail.gmail.com> <20060311.183904.71244086.davem@davemloft.net>
In-Reply-To: <20060311.183904.71244086.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
> Date: Sun, 12 Mar 2006 02:51:40 +0100
> 
> 
>>I have noticed this warnings
>>TCP: Treason uncloaked! Peer 82.113.55.2:11759/50967 shrinks window
>>148470938:148470943. Repaired.
>>TCP: Treason uncloaked! Peer 82.113.55.2:11759/50967 shrinks window
>>148470938:148470943. Repaired.
>>TCP: Treason uncloaked! Peer 82.113.55.2:11759/59768 shrinks window
>>1124211698:1124211703. Repaired.
>>TCP: Treason uncloaked! Peer 82.113.55.2:11759/59768 shrinks window
>>1124211698:1124211703. Repaired.
>>
>>It maybe problem with ktorrent.
> 
> 
> It is a problem with the remote TCP implementation, it is
> illegally advertising a smaller window that it previously
> did.
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Packeteer manipulates window for shaping. I probably misread/read wrong 
RFC on this but I thought it didn't break any MUST NOTs.

I assume Linux + SFQ reordering packets during window growth would not 
trigger it.

Andy.

