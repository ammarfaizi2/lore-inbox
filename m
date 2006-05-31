Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWEaJDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWEaJDN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 05:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWEaJDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 05:03:13 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:41162 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S964873AbWEaJDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 05:03:12 -0400
Date: Wed, 31 May 2006 13:03:02 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>, draghuram@rocketmail.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Question about tcp hash function tcp_hashfn()
Message-ID: <20060531090301.GA26782@2ka.mipt.ru>
References: <20060530235525.A30563@openss7.org> <20060531.001027.60486156.davem@davemloft.net> <20060531014540.A1319@openss7.org> <20060531.004953.91760903.davem@davemloft.net> <20060531020009.A1868@openss7.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060531020009.A1868@openss7.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 31 May 2006 13:03:03 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 02:00:09AM -0600, Brian F. G. Bidulock (bidulock@openss7.org) wrote:
> > For sure and there are plans afoot to move over to
> > dynamic table sizing and the Jenkins hash function.
> 
> Yes, that could be far more efficient.

In theory practice and theory are the same, but in practice they are
different.

Current simple XOR hash used in socket selection code is just bloody good!
Jenkins hash unfortunately has _significant_ artefacts which were found
in netchannel [1] hash selection analysis [2].
And Jenkins hash is far too slower.

1. Netchannel.
http://tservice.net.ru/~s0mbre/old/?section=projects&item=netchannel

2. Compared Jenkins hash with XOR hash used in TCP socket selection
code.
http://tservice.net.ru/~s0mbre/blog/2006/05/14#2006_05_14

-- 
	Evgeniy Polyakov
