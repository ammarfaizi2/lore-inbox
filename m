Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbTGGQi5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 12:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267074AbTGGQi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 12:38:57 -0400
Received: from evrtwa1-ar2-4-33-045-074.evrtwa1.dsl-verizon.net ([4.33.45.74]:31952
	"EHLO grok.yi.org") by vger.kernel.org with ESMTP id S265091AbTGGQi4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 12:38:56 -0400
Message-ID: <3F09A57D.8030003@candelatech.com>
Date: Mon, 07 Jul 2003 09:53:17 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: RFC: another approach for 64-bit network stats
References: <3F097E4D.1080707@trash.net>
In-Reply-To: <3F097E4D.1080707@trash.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy wrote:
> This patch implements a lockless aproach for 64-bit netstatistics with 
> only a very rare
> racecondition. On 64 bit system, nothing is changed. On 32 bit system 

I think that you should consider providing a new API as opposed to
breaking existing APIs.

And, perhaps this new API could deal with the very rare race to make
it never happen?  No matter how rare it is, you still have to write code
to work around it if it exists..might as well do it once in the kernel
instead of making each user of the interface deal with it.

Personally, I'd like to see the net-device stats (64-bit or otherwise) available
through the ethtool interface in a well defined binary package (perhaps a
struct net_device_stats, or similar.)

Ben



-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


