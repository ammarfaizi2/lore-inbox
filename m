Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVFWACc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVFWACc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 20:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVFWACc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 20:02:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:4013 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261689AbVFWAC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 20:02:27 -0400
X-Authenticated: #26200865
Message-ID: <42B9FC19.2000604@gmx.net>
Date: Thu, 23 Jun 2005 02:02:33 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.7) Gecko/20050414
X-Accept-Language: de, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Patrick McHardy <kaber@trash.net>, Bart De Schuymer <bdschuym@telenet.be>,
       Bart De Schuymer <bdschuym@pandora.be>, netfilter-devel@manty.net,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       ebtables-devel@lists.sourceforge.net, rankincj@yahoo.com
Subject: Re: 2.6.12: connection tracking broken?
References: <E1Dk9nK-0001ww-00@gondolin.me.apana.org.au>	<Pine.LNX.4.62.0506200432100.31737@kaber.coreworks.de>	<1119249575.3387.3.camel@localhost.localdomain>	<42B6B373.20507@trash.net>	<1119293193.3381.9.camel@localhost.localdomain>	<42B74FC5.3070404@trash.net>	<1119338382.3390.24.camel@localhost.localdomain>	<42B82F35.3040909@trash.net> <20050622214920.GA13519@gondor.apana.org.au>
In-Reply-To: <20050622214920.GA13519@gondor.apana.org.au>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu schrieb:
> 
> Longer term though we should obsolete the ipt_physdev module.  The
> rationale there is that this creates a precedence that we can't
> possibly maintain in a consistent way.  For example, we don't have
> a target that matches by hardware MAC address.  If you wanted to
> do that, you'd hook into the arptables interface rather than deferring
> iptables after the creation of the hardware header.
> 
> This can be done in two stages to minimise pain for people already
> using it:
> 
> 1) We rewrite ipt_physdev to do the lookups necessary to get the output
> physical devices through the bridge layer.  Of course this may not be
> the real output device due to changes in the environment.  So this should
> be accompanied with a warning that users should switch to ebt.
> 
> 2) We remove the iptables deferring since ipt_physdev will no longer need
> it.
> 
> 3) After a set period (say a year or so) we remove ipt_physdev altogether.

For my local setup it is already a minor PITA that there is no tool
combining the functionality of arptables, ebtables and iptables, but
I can cope with the help of marking and ipt_physdev. If that doesn't
work reliably anymore, I'll be stuck.

Wasn't someone working on a unified framework for *tables? IIRC that
would have been pkttables, but Harald(?) said there was not much
code there yet.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
