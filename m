Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265039AbTBEV5f>; Wed, 5 Feb 2003 16:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbTBEV5f>; Wed, 5 Feb 2003 16:57:35 -0500
Received: from quechua.inka.de ([193.197.184.2]:29114 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S265039AbTBEV5e>;
	Wed, 5 Feb 2003 16:57:34 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: disabling nagle
References: <F137jnt61tqeaVRMPjc00012673@hotmail.com>
Organization: private Linux site, southern Germany
Date: Wed, 05 Feb 2003 22:58:25 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E18gXYn-0002si-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> would be to create a patch to disable TCP's timeout and retransmit
> mechanisms on a given interface?  This would allow those of us who have no
> alternative other than PPP over ssh for VPN to greatly improve performance.
> Over a well behaved connection this works acceptably, but given any delays
> or packet loss it is essentially unusable.  I know the real answer is using
> something other than TCP as the transport layer for the tunnel (IPSEC, IP
> over IP, UDP, etc.) but that isn't always possible.  So I'd like a way to
> treat the ppp interface the VPN tunnel creates as a completely reliable
> transport for which normal TCP/IP retransmits and timeouts don't apply.

As I see it, this wouldn't help when the TCP retransmits are
originated by a machine other than the VPN routers, because they don't
know about the new reliability characteristics of their transport
medium. So in any network with more than two machines its usefulness
is rather limited. (Or am I missing something?)

Olaf

