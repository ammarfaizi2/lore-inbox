Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752507AbWAGCSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbWAGCSG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 21:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752504AbWAGCSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 21:18:06 -0500
Received: from cantor2.suse.de ([195.135.220.15]:33188 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752500AbWAGCSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 21:18:04 -0500
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH, RFC] RCU : OOM avoidance and lower latency
Date: Sat, 7 Jan 2006 02:09:01 +0100
User-Agent: KMail/1.8.2
Cc: paulmck@us.ibm.com, dada1@cosmosbay.com, alan@lxorguk.ukuu.org.uk,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       manfred@colorfullife.com, netdev@vger.kernel.org
References: <43BEA693.5010509@cosmosbay.com> <200601062157.42470.ak@suse.de> <20060106.161721.124249301.davem@davemloft.net>
In-Reply-To: <20060106.161721.124249301.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601070209.02157.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 January 2006 01:17, David S. Miller wrote:

> 
> I mean something like this patch:

Looks like a good idea to me.

I always disliked the per chain spinlocks even for other hash tables like
TCP/UDP multiplex - it would be much nicer to use a much smaller separately 
hashed lock table and save cache. In this case the special case of using
a one entry only lock hash table makes sense.

-Andi
