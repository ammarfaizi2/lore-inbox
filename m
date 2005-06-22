Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbVFVAqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbVFVAqB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 20:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVFVAqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 20:46:01 -0400
Received: from [62.206.217.67] ([62.206.217.67]:7583 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S262296AbVFVAp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 20:45:56 -0400
Message-ID: <42B8B4BD.107@trash.net>
Date: Wed, 22 Jun 2005 02:45:49 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050514 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Bart De Schuymer <bdschuym@pandora.be>
CC: Bart De Schuymer <bdschuym@telenet.be>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       rankincj@yahoo.com, ebtables-devel@lists.sourceforge.net,
       netfilter-devel@manty.net
Subject: Re: 2.6.12: connection tracking broken?
References: <E1Dk9nK-0001ww-00@gondolin.me.apana.org.au>	 <Pine.LNX.4.62.0506200432100.31737@kaber.coreworks.de>	 <1119249575.3387.3.camel@localhost.localdomain> <42B6B373.20507@trash.net>	 <1119293193.3381.9.camel@localhost.localdomain>	 <42B74FC5.3070404@trash.net>	 <1119338382.3390.24.camel@localhost.localdomain>	 <42B82F35.3040909@trash.net> <1119386772.3379.4.camel@localhost.localdomain>
In-Reply-To: <1119386772.3379.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart De Schuymer wrote:
> Op di, 21-06-2005 te 17:16 +0200, schreef Patrick McHardy:
> 
>>I unfortunately don't see a way to remove it, but we should keep
>>thinking about it. Can you please check if the attached patch is
>>correct? It should exclude all packets handled by bridge-netfilter
>>from having their conntrack reference dropped. I didn't add nf_reset()'s
>>to the bridging code because with tc actions the packets can end up
>>anywhere else anyway, and this will hopefully get fixed right sometime.
> 
> Looks good.

Thanks.

> Perhaps a compile time option to disable postponing the hooks would be
> nice...

I think we want to reduce the number of possible paths to ideally one,
not make them a compile-time option.

Regards
Patrick
