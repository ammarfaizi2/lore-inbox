Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUCaO5X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 09:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbUCaO5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 09:57:23 -0500
Received: from mail.shareable.org ([81.29.64.88]:27028 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261987AbUCaO5W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 09:57:22 -0500
Date: Wed, 31 Mar 2004 15:57:11 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Jan Kesten <rwe.piller@the-hidden-realm.de>, linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.4 and nfs lockd.udpport?
Message-ID: <20040331145711.GB18990@mail.shareable.org>
References: <200403290958.i2T9w2fJ029554@mail.bytecamp.net> <1080587948.2410.68.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080587948.2410.68.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> > I read the docs and found that the parameters sould be lockd.udpport and 
> > lockd.tcpport=xxx - but this doesn't work. While booting I got errors that 
> > both are unknown boot options. 
> > 
> > Where is my mistake? 
> 
> Someone updated lockd so that it uses a sysctl-based interface instead.
> Apparently without changing the docs.

I added the sysctl-based interface, and kept the modules parameters,
and updated the code in line with the 2.6 module parameter style.
See the "module_param_call" lines in fs/lockd/svc.c.

The module parameters "nlm_udpport" and "nlm_tcpport" _do_ work -- I
use them with my firewall.

For some reason, because modules don't need #ifdef MODULE any more, I
thought module_param*() entries would be automatically available as
boot parameters.  Silly me, that would be too obvious.

-- Jamie
