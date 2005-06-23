Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVFWDbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVFWDbu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 23:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVFWDbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 23:31:49 -0400
Received: from [62.206.217.67] ([62.206.217.67]:973 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S262041AbVFWDbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 23:31:47 -0400
Date: Thu, 23 Jun 2005 05:31:39 +0200 (CEST)
From: Patrick McHardy <kaber@trash.net>
X-X-Sender: kaber@kaber.coreworks.de
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
cc: Herbert Xu <herbert@gondor.apana.org.au>,
       Bart De Schuymer <bdschuym@telenet.be>,
       Bart De Schuymer <bdschuym@pandora.be>, netfilter-devel@manty.net,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       ebtables-devel@lists.sourceforge.net, rankincj@yahoo.com
Subject: Re: 2.6.12: connection tracking broken?
In-Reply-To: <42B9FC19.2000604@gmx.net>
Message-ID: <Pine.LNX.4.62.0506230527460.12228@kaber.coreworks.de>
References: <E1Dk9nK-0001ww-00@gondolin.me.apana.org.au>
 <Pine.LNX.4.62.0506200432100.31737@kaber.coreworks.de>
 <1119249575.3387.3.camel@localhost.localdomain> <42B6B373.20507@trash.net>
 <1119293193.3381.9.camel@localhost.localdomain> <42B74FC5.3070404@trash.net>
 <1119338382.3390.24.camel@localhost.localdomain> <42B82F35.3040909@trash.net>
 <20050622214920.GA13519@gondor.apana.org.au> <42B9FC19.2000604@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2005, Carl-Daniel Hailfinger wrote:

> Herbert Xu schrieb:
>>
>> 3) After a set period (say a year or so) we remove ipt_physdev altogether.
>
> For my local setup it is already a minor PITA that there is no tool
> combining the functionality of arptables, ebtables and iptables, but
> I can cope with the help of marking and ipt_physdev. If that doesn't
> work reliably anymore, I'll be stuck.

You would still be able to mark packets in iptables and match on that
mark in ebtables, where filtering on the bridge port can be performed.

> Wasn't someone working on a unified framework for *tables? IIRC that
> would have been pkttables, but Harald(?) said there was not much
> code there yet.

Not much has changed AFAIK, but pkttables wouldn't change the fact
that the bridge port isn't available at the IP layer.

Regards
Patrick
