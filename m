Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270803AbTG0OMo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 10:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270805AbTG0OMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 10:12:44 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:19637 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S270803AbTG0OMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 10:12:39 -0400
Message-ID: <3F23E538.6010900@genebrew.com>
Date: Sun, 27 Jul 2003 10:44:08 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew de Quincey <adq_dvb@lidskialf.net>
CC: Marcelo Penna Guerra <eu@marcelopenna.org>,
       lkml <linux-kernel@vger.kernel.org>, Laurens <masterpe@xs4all.nl>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] nvidia nforce 1.0-261 nvnet for kernel 2.5
References: <200307262309.20074.adq_dvb@lidskialf.net> <200307271301.41660.adq_dvb@lidskialf.net> <3F23DB4E.1000203@genebrew.com> <200307271514.00724.adq_dvb@lidskialf.net>
In-Reply-To: <200307271514.00724.adq_dvb@lidskialf.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew de Quincey wrote:
> Hmm, I have a suspicion it is not unfortunately, given the change in location 
> of the MAC address. Or maybe nvidia have displaced the configuration 
> registers by some amount?

Dunno. Look in the list archives for earlier discussions on the topic. 
It seems AMD audio is a clone of Intel audio, which is why Intel audio 
works for NForce. Since both audio and ethernet match, it seems unlikely 
that Nvidia would license a completely different ethernet chip, but who 
knows?

Anyway, I want to put as much info out there as possible for someone to 
use as they wish. So here's another tip:

00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet 
Controller (rev a1)
00: de 10 66 00 07 00 b0 00 a1 00 00 02 00 00 00 00
10: 00 00 00 e0 01 c4 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 0c 57
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 01 14
40: 62 14 0c 57 01 00 02 fe 00 01 00 00 04 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Note the first row reads:
00: de 10 66 00 07 00 b0 00 a1 00 00 02 00 00 00 00

Before nvnet loads, the same row reads:
00: de 10 66 00 03 00 b0 00 a1 00 00 02 00 00 00 00

Don't know if that is significant.

-Rahul
-- 
Rahul Karnik
rahul@genebrew.com

