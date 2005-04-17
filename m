Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVDRBMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVDRBMc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 21:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVDRBMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 21:12:32 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:53440 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261406AbVDRBMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 21:12:30 -0400
Message-Id: <200504172337.j3HNbJsA004220@laptop11.inf.utfsm.cl>
To: Andreas Hartmann <andihartmann@01019freenet.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: More performance for the TCP stack by using additional hardware chip on NIC 
In-Reply-To: Message from Andreas Hartmann <andihartmann@01019freenet.de> 
   of "Sun, 17 Apr 2005 10:17:49 +0200." <d3t63d$3qe$1@pD9F86D3F.dip0.t-ipconnect.de> 
Date: Sun, 17 Apr 2005 19:37:18 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Hartmann <andihartmann@01019freenet.de> said:
> Alacritech developed a new chip for NIC's
> (http://www.alacritech.com/html/tech_review.html), which makes it possible
> to take away the TCP stack from the host CPU. Therefore, the host CPU has
> more performance for the applications according Alacritech.
> 
> This sounds interesting.

This idea has been discussed around here a couple of times, and the
consensus is that it is a bad idea: IP (and upper protocol) processing
is not expensive, if done right, so this really doesn't buy much; this
forces a particular interface to networking into the kernel, loosing
flexibility that way is always bad; there is no access to futzing
around in between (for example, for firewalling and such); and if the
"hardware implementation" has bugs, you are screwed.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
