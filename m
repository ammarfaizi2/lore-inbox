Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267922AbUGaJfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267922AbUGaJfT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 05:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267923AbUGaJfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 05:35:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46216 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267922AbUGaJfC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 05:35:02 -0400
Message-ID: <410B67B1.4080906@pobox.com>
Date: Sat, 31 Jul 2004 05:34:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, greearb@candelatech.com,
       akpm@osdl.org, alan@redhat.com, jgarzik@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
References: <20040730121004.GA21305@alpha.home.local> <E1BqkzY-0003mK-00@gondolin.me.apana.org.au> <20040731083308.GA24496@alpha.home.local>
In-Reply-To: <20040731083308.GA24496@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
>   - many (all ?) other drivers already have an MTU parameter, and many

s/many/almost none/


>     of them don't have a problem with using generic change_mtu(). So why
>     would this one in particular need such a change ? (and please don't
>     tell me that *I* will have to do this for all others :-))

For VLAN support you definitely want to let the user increase the size 
above 1500, and for that you need ->change_mtu

	Jeff


