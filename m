Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVGYOjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVGYOjI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 10:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVGYOd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 10:33:58 -0400
Received: from p54A0B012.dip0.t-ipconnect.de ([84.160.176.18]:51453 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261238AbVGYOdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 10:33:12 -0400
Message-ID: <42E4F800.1010908@trash.net>
Date: Mon, 25 Jul 2005 16:32:32 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: James Morris <jmorris@redhat.com>, "David S. Miller" <davem@davemloft.net>,
       Harald Welte <laforge@netfilter.org>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, netdev@redhat.com,
       netdev@vger.kernel.org
Subject: Re: Netlink connector
References: <20050723125427.GA11177@rama> <20050723091455.GA12015@2ka.mipt.ru> <20050724.191756.105797967.davem@davemloft.net> <Lynx.SEL.4.62.0507250154000.21934@thoron.boston.redhat.com> <20050725070603.GA28023@2ka.mipt.ru>
In-Reply-To: <20050725070603.GA28023@2ka.mipt.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> On Mon, Jul 25, 2005 at 02:02:10AM -0400, James Morris (jmorris@redhat.com) wrote:
> 
>>On Sun, 24 Jul 2005, David S. Miller wrote:
>>
>>>From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
>>>Date: Sat, 23 Jul 2005 13:14:55 +0400
>>>
>>>
>>>>Andrew has no objection against connector and it lives in -mm
>>>
>>>A patch sitting in -mm has zero significance.
> 
> That is why I'm asking netdev@ people again...

If I understand correctly it tries to workaround some netlink
limitations (limited number of netlink families and multicast groups)
by sending everything to userspace and demultiplexing it there.
Same in the other direction, an additional layer on top of netlink
does basically the same thing netlink already does. This looks like
a step in the wrong direction to me, netlink should instead be fixed
to support what is needed.
