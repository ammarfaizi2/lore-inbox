Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264251AbUG2TJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUG2TJn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 15:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbUG2TIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 15:08:04 -0400
Received: from 62-43-34-140.user.ono.com ([62.43.34.140]:29826 "EHLO
	bacterio.pirispons.net") by vger.kernel.org with ESMTP
	id S264704AbUG2TEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 15:04:04 -0400
Date: Thu, 29 Jul 2004 21:04:01 +0200
From: Kiko Piris <kernel@pirispons.net>
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: ipsec and/or netfilter problem
Message-ID: <20040729190401.GA11195@mortadelo.pirispons.net>
Mail-Followup-To: Patrick McHardy <kaber@trash.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>
References: <20040728212823.GA19345@mortadelo.pirispons.net> <410844F2.3030503@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410844F2.3030503@trash.net>
User-Agent: Mutt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please CC me on reply, I'm subscribed to linux-kernel
but not to netfilter-devel ]

On 29/07/2004 at 02:29 +0200, Patrick McHardy wrote:

> Kiko Piris wrote:
> >The problem is that the server sends the data to Internet without doing
> >SNAT (checked with tcpdump) (the packets do not traverse the POSTROUTING
> >chain in nat table, checked watching the pkts counters).
> >
> >Anyone has any hint?
> 
> You could try the netfilter+ipsec patches in netfilter patch-o-matic-ng,
> they should solve this problem,

Hi Patrick

I've tried those patches with 2.6.6 and I see the same behaviour,
packets do not traverse POSTROUTING chain in nat table (and thus they
are not s-natted).

What I did was to manually aply the following patches from
patch-o-matic-ng-20040621 to a vanilla 2.6.6 tree:

nf_reset
ipsec-01-output-hooks
ipsec-02-input-hooks
ipsec-03-policy-lookup
ipsec-04-policy-checks

did I miss something? (I understood from your email and from
patch-o-matic-ng-20040621/ipsec-*/info files that this was enough, maybe
it wasn't... O:-).

> The current patches only apply to 2.6.6, but I will update them next
> week

I can wait until then, no problem...

Thanks a lot for responding.

-- 
Kiko
