Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVCKStz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVCKStz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 13:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVCKSoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 13:44:23 -0500
Received: from mx04.cybersurf.com ([209.197.145.108]:55228 "EHLO
	mx04.cybersurf.com") by vger.kernel.org with ESMTP id S261252AbVCKSep
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 13:34:45 -0500
Subject: Re: [PATCH] updated, ethernet-bridge: update skb->priority in case
	forwarded frame has VLAN-header
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Stephen Hemminger <shemminger@osdl.org>
Cc: "leo.yuriev.ru" <leo@yuriev.ru>,
       Lennert Buytenhek <buytenh@wantstofly.org>,
       Patrick McHardy <kaber@trash.net>, Ben Greear <greearb@candelatech.com>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050311093724.6c8b6a6d@dxpl.pdx.osdl.net>
References: <914610115.20050311172022@yuriev.ru>
	 <20050311093724.6c8b6a6d@dxpl.pdx.osdl.net>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1110566077.1071.16.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Mar 2005 13:34:37 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Actually there is a case to be made for this to be part of the
bridge code. A VLAN is a single collision domain which is mappable to a
collission domain that is a bridge.
infact the old VLAN code written by Lennert (and somebody else) had
those two intermingled.

cheers,
jamal

On Fri, 2005-03-11 at 12:37, Stephen Hemminger wrote:
> On Fri, 11 Mar 2005 17:20:22 +0300
> Leo Yuriev <leo@yuriev.ru> wrote:
> 
> > Kernel 2.6 (2.6.11)
> > 
> > When ethernet-bridge forward a packet and such ethernet-frame has
> > VLAN-tag, bridge should update skb->prioriry for properly QoS
> > handling. This small patch does this.
> > 
> > Based upon discussion during last week I added pskb_may_pull()
> > checking and simple mapping from 802.1p/user_priority to skb->priority.
> > 
> > Patch-by: Leo Yuriev <leo@yuriev.ru>
> 
> Do this as an ebtables module please.
> 

