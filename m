Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264930AbTIDLPq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 07:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264932AbTIDLPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 07:15:46 -0400
Received: from ns2.questra.com ([64.132.48.187]:43533 "EHLO ns2.questra.com")
	by vger.kernel.org with ESMTP id S264930AbTIDLPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 07:15:45 -0400
Date: Thu, 4 Sep 2003 07:15:43 -0400
From: Scott Mcdermott <smcdermott@questra.com>
To: netfilter@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: SNAT interaction with kernel-based IPSEC (in 2.6)
Message-ID: <20030904111543.GT17837@questra.com>
Mail-Followup-To: netfilter@lists.netfilter.org,
	linux-kernel@vger.kernel.org
References: <20030904091525.GO17837@questra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030904091525.GO17837@questra.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To netfilter@lists.netfilter.org on Thu  4/09 05:15 -0400:
> I'm having some difficulty doing simple pings over an
> IPSEC tunnel using the implementation in 2.6.0-test4 (with
> Racoon, and successful Phase 1 and 2, I get the IPSEC SA
> fine), in combination with iptables.

Nevermind this, I had set the security policy with the wrong
/24 on the remote end.  It's now working great with IPSEC
and doing SNAT only when it doesn't traverse the tunnel.
I'm really surprised that it "just works."  The IPSEC in 2.6
is very good IMO, basically turnkey.

It still would be nice to know where IPSEC fits in to the
Netfilter engine (ie, why it does "just work" and not SNAT
when it goes over the tunnel), but it works great now...I
think RTFS is in order.
