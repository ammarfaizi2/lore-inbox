Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262424AbSJVXL7>; Tue, 22 Oct 2002 19:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262440AbSJVXL7>; Tue, 22 Oct 2002 19:11:59 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:8142 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S262424AbSJVXL4>;
	Tue, 22 Oct 2002 19:11:56 -0400
Message-ID: <3DB5DC5D.3020701@candelatech.com>
Date: Tue, 22 Oct 2002 16:16:45 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@rth.ninka.net>
CC: Matti Aarnio <matti.aarnio@zmailer.org>,
       Slavcho Nikolov <snikolov@okena.com>, linux-kernel@vger.kernel.org
Subject: Re: feature request - why not make netif_rx() a pointer?
References: <00b201c27a0e$3f82c220$800a140a@SLNW2K> 	<20021022211535.GZ1111@mea-ext.zmailer.org> <1035326559.16085.18.camel@rth.ninka.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Tue, 2002-10-22 at 14:15, Matti Aarnio wrote:
> 
>>  ftp://zmailer.org/linux/netif_rx.patch
> 
> 
> Please EXPORT_GPL this, if you are going to do it at all.
> 
> Only non-GPL compliant binary-modules can result from this
> change.
> 
> People can easily do things like implement their own entire
> networking stack with this hook, which is not what we want nor
> is it allowed.

Don't assume we all want what you want.

As for allowed, it can
be worked around fairly easily by removing all protocol handlers and
then registering only yourself as the proprietary protocol handler,
and gobble all packets.  Sure, it's a bit of a kludge, and will have
the various crufts (like the gettimeofday code) in there, but it
will basically allow you to replace the entire stack.

If I'm right about that, then what is the difference between replacing
the stack like that and replacing the netif_rx method entirely?

Ben


> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


