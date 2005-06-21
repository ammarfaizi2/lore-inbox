Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbVFUUh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbVFUUh3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbVFUUf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:35:26 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:30853 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262318AbVFUUdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:33:18 -0400
Subject: Re: 2.6.12: connection tracking broken?
From: Bart De Schuymer <bdschuym@pandora.be>
To: Patrick McHardy <kaber@trash.net>
Cc: Bart De Schuymer <bdschuym@telenet.be>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       rankincj@yahoo.com, ebtables-devel@lists.sourceforge.net,
       netfilter-devel@manty.net
In-Reply-To: <42B82F35.3040909@trash.net>
References: <E1Dk9nK-0001ww-00@gondolin.me.apana.org.au>
	 <Pine.LNX.4.62.0506200432100.31737@kaber.coreworks.de>
	 <1119249575.3387.3.camel@localhost.localdomain> <42B6B373.20507@trash.net>
	 <1119293193.3381.9.camel@localhost.localdomain>
	 <42B74FC5.3070404@trash.net>
	 <1119338382.3390.24.camel@localhost.localdomain>
	 <42B82F35.3040909@trash.net>
Content-Type: text/plain
Date: Tue, 21 Jun 2005 20:46:12 +0000
Message-Id: <1119386772.3379.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Op di, 21-06-2005 te 17:16 +0200, schreef Patrick McHardy:
> I unfortunately don't see a way to remove it, but we should keep
> thinking about it. Can you please check if the attached patch is
> correct? It should exclude all packets handled by bridge-netfilter
> from having their conntrack reference dropped. I didn't add nf_reset()'s
> to the bridging code because with tc actions the packets can end up
> anywhere else anyway, and this will hopefully get fixed right sometime.

Looks good.
Perhaps a compile time option to disable postponing the hooks would be
nice...

> BTW. this line from ip_sabotage_out() looks wrong, it will clear all
> flags instead of setting the BRNF_DONT_TAKE_PARENT flag (second
> patch):
> 
>                         nf_bridge->mask &= BRNF_DONT_TAKE_PARENT;

Thanks,
Bart


