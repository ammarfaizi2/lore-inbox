Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268884AbUHUHhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268884AbUHUHhA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 03:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268885AbUHUHg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 03:36:59 -0400
Received: from main.gmane.org ([80.91.224.249]:59036 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268884AbUHUHgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 03:36:43 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level
Date: Sat, 21 Aug 2004 16:36:34 +0900
Message-ID: <cg6u22$kk$1@sea.gmane.org>
References: <4126F16D.1000507@gmc.lt> <S268868AbUHUHCe/20040821070234Z+1825@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: j110113.ppp.asahi-net.or.jp
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040627
X-Accept-Language: bg, en, ja, ru, de
In-Reply-To: <S268868AbUHUHCe/20040821070234Z+1825@vger.kernel.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josan Kadett wrote:
> It is definetely impossible to use IPTables to handle packets with incorrect
> checksums since NAT would drop the connection right away, otherwise I would
> not have been asking this question here.
> 
> -----Original Message-----
> From: Aidas Kasparas [mailto:a.kasparas@gmc.lt] 
> Sent: Saturday, August 21, 2004 8:54 AM
> To: Josan Kadett
> Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level
> 
> How about setting up a separate box which would listen on that 
> 192.168.77.1 address and MASQUERADE connections to your crazy box from 
> 192.168.1.x address? Maybe then you would no longer need to break things 
>   in kernel?

Isn't rp_filter for this?

A chunk of my iptables firewall script is:

# Force route verification
for f in /proc/sys/net/ipv4/conf/*/rp_filter; do echo 1 > $f; done

So why don't you try:
for f in /proc/sys/net/ipv4/conf/*/rp_filter; do echo "0" > $f; done

Kalin.

-- 
 || ~~~~~~~~~~~~~~~~~~~~~~ ||
(  ) http://ThinRope.net/ (  )
 || ______________________ ||

