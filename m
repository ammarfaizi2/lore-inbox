Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267591AbUGaQFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267591AbUGaQFa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 12:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267699AbUGaQF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 12:05:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36753 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267591AbUGaQFU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 12:05:20 -0400
Message-ID: <410BC32F.7050107@pobox.com>
Date: Sat, 31 Jul 2004 12:05:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, greearb@candelatech.com,
       akpm@osdl.org, alan@redhat.com, jgarzik@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
References: <20040730121004.GA21305@alpha.home.local> <E1BqkzY-0003mK-00@gondolin.me.apana.org.au> <20040731083308.GA24496@alpha.home.local> <410B67B1.4080906@pobox.com> <20040731101152.GG1545@alpha.home.local>
In-Reply-To: <20040731101152.GG1545@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Hi Jeff,
> 
> On Sat, Jul 31, 2004 at 05:34:41AM -0400, Jeff Garzik wrote:
> 
>>Willy Tarreau wrote:
>>
>>> - many (all ?) other drivers already have an MTU parameter, and many
>>
>>s/many/almost none/
> 
> 
> Ok, sorry, I've just checked, they are 6. But I incidentely used the feature
> on 2 of them (dl2k and starfire). But more drivers still have the
> 'static int mtu=1500' preceeded by a comment stating "allow the user to change
> the mtu". Why is it not a #define then, if nobody can change it anymore ?

People can change it all the time with ifconfig.


> Jeff, do you know the absolute hardware limit on the tulip ? I've seen the

It depends on the tulip.

Look at Donald Becker's tulip.c for reference, it has full ->change_mtu 
support (as does 3c59x.c I believe).

	Jeff


