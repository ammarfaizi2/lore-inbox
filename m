Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267971AbUGaROP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267971AbUGaROP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 13:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267973AbUGaROP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 13:14:15 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:8163 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S267971AbUGaROL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 13:14:11 -0400
Message-ID: <410BD356.8010205@candelatech.com>
Date: Sat, 31 Jul 2004 10:13:58 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Matti Aarnio <matti.aarnio@zmailer.org>, Willy Tarreau <willy@w.ods.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, akpm@osdl.org,
       alan@redhat.com, jgarzik@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
References: <20040730121004.GA21305@alpha.home.local> <E1BqkzY-0003mK-00@gondolin.me.apana.org.au> <20040731083308.GA24496@alpha.home.local> <410B67B1.4080906@pobox.com> <20040731101152.GG1545@alpha.home.local> <20040731141222.GJ2429@mea-ext.zmailer.org> <410BC655.4040509@pobox.com>
In-Reply-To: <410BC655.4040509@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Matti Aarnio wrote:
> 

>> For this IFCONFIG MTU issue, I would rather have the VLAN code to ask
>> the underlaying driver of what MTU can be supported, than just blindly
>> presume that 1500 will be functional for e.g. eth0.2  (like it does now)
> 
> 
> The VLAN code could certainly be updated to poke at the lower level 
> driver MTU.

Please do not do this without more discussion.  This could easily
break the current ability to use the regular ethernet device in the
normal manner, regardless of the existence of VLANs.  I'd rather
not loose this capability across the board just to work around a few
broken drivers.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

