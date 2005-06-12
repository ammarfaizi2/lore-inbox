Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262621AbVFLPGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbVFLPGn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 11:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbVFLPGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 11:06:43 -0400
Received: from [62.206.217.67] ([62.206.217.67]:28352 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S262621AbVFLPGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 11:06:38 -0400
Message-ID: <42AC4F5B.1040907@trash.net>
Date: Sun, 12 Jun 2005 17:06:03 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050514 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
CC: Phil Oester <kernel@linuxace.com>, cedric@schieli.dyndns.org,
       coreteam@netfilter.org, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org
Subject: Re: [netfilter-core] Re: [PATCH] Avoid unncessary checksum validation
 in TCP/UDP netfilter
References: <E1DbccR-00063Q-00@mta1.cl.cam.ac.uk>	<20050527112039.GA10084@linuxace.com> <875052371a3a7c5217e413d7250320f9@cl.cam.ac.uk>
In-Reply-To: <875052371a3a7c5217e413d7250320f9@cl.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keir Fraser wrote:
> On 27 May 2005, at 12:20, Phil Oester wrote:
>> On Fri, May 27, 2005 at 12:03:08PM +0100, Keir Fraser wrote:
>>
>>> The TCP/UDP connection-tracking code in netfilter validates the
>>> checksum of incoming packets, to prevent nastier errors further down
>>> the road. This check is unnecessary if the skb is marked as
>>> CHECKSUM_UNNECESSARY.
>>
>> It seems at least part of this has already been merged in 2.6.12-rc
> 
> It would be great if the UDP code also would observe
> CHECKSUM_UNNECESSARY. I'll wait for 2.6.12 to appear and then submit a
> new patch if UDP has been missed.

TCP was changed to fix a regression with loopback packets. I've added
the UDP part of your patch to my 2.6.13 tree.

Regards
Patrick
