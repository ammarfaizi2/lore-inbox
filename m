Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVB1Pbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVB1Pbv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 10:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVB1Pbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 10:31:51 -0500
Received: from mx02.cybersurf.com ([209.197.145.105]:28377 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S261649AbVB1Pbp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 10:31:45 -0500
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Thomas Graf <tgraf@suug.ch>
Cc: Andrew Morton <akpm@osdl.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       kaigai@ak.jp.nec.com, marcelo.tosatti@cyclades.com,
       "David S. Miller" <davem@redhat.com>, jlan@sgi.com,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, elsa-devel@lists.sourceforge.net
In-Reply-To: <20050228142551.GQ31837@postel.suug.ch>
References: <4221E548.4000008@ak.jp.nec.com>
	 <20050227140355.GA23055@logos.cnet> <42227AEA.6050002@ak.jp.nec.com>
	 <1109575236.8549.14.camel@frecb000711.frec.bull.fr>
	 <20050227233943.6cb89226.akpm@osdl.org>
	 <1109592658.2188.924.camel@jzny.localdomain>
	 <20050228132051.GO31837@postel.suug.ch>
	 <1109598010.2188.994.camel@jzny.localdomain>
	 <20050228135307.GP31837@postel.suug.ch>
	 <1109599803.2188.1014.camel@jzny.localdomain>
	 <20050228142551.GQ31837@postel.suug.ch>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1109604693.1072.8.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 28 Feb 2005 10:31:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-28 at 09:25, Thomas Graf wrote:
> * jamal <1109599803.2188.1014.camel@jzny.localdomain> 2005-02-28 09:10
[..]
> > To justify writting the new code, I am assuming someone has actually sat
> > down and in the minimal stuck their finger in the air
> > and said "yes, there is definetely wind there".
> 
> I did, not for this problem though. The code this idea comes from sends
> batched events 

I would bet the benefit you are seeing has to do with batching rather
than such an optimization flag. Different ballgame.
I relooked at their code snippet, they dont even have skbs built nor
even figured out what sock or PID. That work still needs to be done it
seems in cn_netlink_send(). So probably all they need to do is move the
check in cn_netlink_send() instead. This is assuming they are not
scratching their heads with some realted complexities.

I am gonna disapear for a while; hopefully the original posters have
gathered some ideas from what we discussed.

cheers,
jamal

