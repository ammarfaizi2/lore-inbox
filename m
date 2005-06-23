Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbVFWGLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbVFWGLR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 02:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbVFWGLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:11:16 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:41350 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262220AbVFWGKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:10:13 -0400
Subject: Re: 2.6.12: connection tracking broken?
From: Bart De Schuymer <bdschuym@pandora.be>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Patrick McHardy <kaber@trash.net>, Bart De Schuymer <bdschuym@telenet.be>,
       netfilter-devel@manty.net, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org, ebtables-devel@lists.sourceforge.net,
       rankincj@yahoo.com
In-Reply-To: <20050622214920.GA13519@gondor.apana.org.au>
References: <E1Dk9nK-0001ww-00@gondolin.me.apana.org.au>
	 <Pine.LNX.4.62.0506200432100.31737@kaber.coreworks.de>
	 <1119249575.3387.3.camel@localhost.localdomain> <42B6B373.20507@trash.net>
	 <1119293193.3381.9.camel@localhost.localdomain>
	 <42B74FC5.3070404@trash.net>
	 <1119338382.3390.24.camel@localhost.localdomain>
	 <42B82F35.3040909@trash.net>  <20050622214920.GA13519@gondor.apana.org.au>
Content-Type: text/plain
Date: Thu, 23 Jun 2005 06:23:20 +0000
Message-Id: <1119507800.3387.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Op do, 23-06-2005 te 07:49 +1000, schreef Herbert Xu:
> Longer term though we should obsolete the ipt_physdev module.  The
> rationale there is that this creates a precedence that we can't
> possibly maintain in a consistent way.  For example, we don't have
> a target that matches by hardware MAC address.  If you wanted to
> do that, you'd hook into the arptables interface rather than deferring
> iptables after the creation of the hardware header.

Iptables also sees purely bridged packets and at least for these packets
the physdev module is useful and harmless. I think removing physdev
alltogether is a bit drastic.

I wonder what flood of messages from angry users the removal of the
physdev functionality for routed packets will stirr.

cheers,
Bart


