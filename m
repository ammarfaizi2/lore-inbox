Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVB1OIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVB1OIE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 09:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVB1OGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 09:06:54 -0500
Received: from eth0-0.arisu.projectdream.org ([194.158.4.191]:10185 "EHLO
	b.mx.projectdream.org") by vger.kernel.org with ESMTP
	id S261610AbVB1Nwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 08:52:47 -0500
Date: Mon, 28 Feb 2005 14:53:07 +0100
From: Thomas Graf <tgraf@suug.ch>
To: jamal <hadi@cyberus.ca>
Cc: Andrew Morton <akpm@osdl.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       kaigai@ak.jp.nec.com, marcelo.tosatti@cyclades.com,
       "David S. Miller" <davem@redhat.com>, jlan@sgi.com,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, elsa-devel@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
Message-ID: <20050228135307.GP31837@postel.suug.ch>
References: <20050224212839.7953167c.akpm@osdl.org> <20050227094949.GA22439@logos.cnet> <4221E548.4000008@ak.jp.nec.com> <20050227140355.GA23055@logos.cnet> <42227AEA.6050002@ak.jp.nec.com> <1109575236.8549.14.camel@frecb000711.frec.bull.fr> <20050227233943.6cb89226.akpm@osdl.org> <1109592658.2188.924.camel@jzny.localdomain> <20050228132051.GO31837@postel.suug.ch> <1109598010.2188.994.camel@jzny.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109598010.2188.994.camel@jzny.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* jamal <1109598010.2188.994.camel@jzny.localdomain> 2005-02-28 08:40
> 
> netlink broadcast or a wrapper around it.
> Why even bother doing the check with netlink_has_listeners()?

To implement the master enable/disable switch they want. The messages
don't get send out anyway but why bother doing all the work if nothing
will get send out in the end? It implements a well defined flag
controlled by open/close on fds (thus handles dying applications)
stating whether the whole code should be enabled or disabled. It is of
course not needed to avoid sending unnecessary messages.
