Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271037AbTG1CUI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 22:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271007AbTG1CTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 22:19:13 -0400
Received: from evrtwa1-ar2-4-33-045-074.evrtwa1.dsl-verizon.net ([4.33.45.74]:35467
	"EHLO grok.yi.org") by vger.kernel.org with ESMTP id S272648AbTG1CQC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 22:16:02 -0400
Message-ID: <3F248AE5.4000204@candelatech.com>
Date: Sun, 27 Jul 2003 19:31:01 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Bas Bloemsaat <bloemsaa@xs4all.nl>, netdev@oss.sgi.com, layes@loran.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
References: <Pine.LNX.4.53.0307272239570.2743@vialle.bloemsaat.com> <20030727151234.6e2aa57e.davem@redhat.com>
In-Reply-To: <20030727151234.6e2aa57e.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Sun, 27 Jul 2003 22:52:48 +0200 (CEST)
> Bas Bloemsaat <bloemsaa@xs4all.nl> wrote:
> 
> 
>>I think this is unwanted behaviour.
> 
> 
> Not a bug.  This behavior is on purpose.

What is the benefit of having it work as it does currently
in the standard kernel?  I too was supprised to find it works
this way, but have since converted to use source-routes.

Interestingly, can only use 252 or so source routes because
the rfc for netlink only gives us an 8-bit identifier for the
route id, so this still breaks if you want to run lots of
vlans or something like that.

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


