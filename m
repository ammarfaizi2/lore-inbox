Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265438AbUAZWMB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 17:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265478AbUAZWMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 17:12:01 -0500
Received: from palrel12.hp.com ([156.153.255.237]:42683 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S265438AbUAZWL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 17:11:57 -0500
Date: Mon, 26 Jan 2004 14:11:53 -0800
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       irda-users@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, linux-net@vger.kernel.org
Subject: Re: [2.4 patch] fix via-ircc.c .text.exit error
Message-ID: <20040126221153.GA18733@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <Pine.LNX.4.58L.0401161207000.28357@logos.cnet> <20040125004030.GE6441@fs.tum.de> <20040126192836.GA17134@bougret.hpl.hp.com> <20040126210126.GG513@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040126210126.GG513@fs.tum.de>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 10:01:26PM +0100, Adrian Bunk wrote:
> On Mon, Jan 26, 2004 at 11:28:36AM -0800, Jean Tourrilhes wrote:
> >
> > 	Thanks you Adrian. Yes, I must confess that I never test
> > non-modular build (because it doesn't work).
> >...
> 
> Are you saying it might compile statically, but it won't work?
> 
> In this case, what about disallowing building it statically in the 
> Config.in?

	I never looked in details at those issues. Some people claim
it works, but personally I always had touble with driver init (double
initialisation). I don't want to disable it if some embedded people
depend on it (stable kernel => stable feature list).
	My "solution" was to totally rework the driver init (and stack
init) in 2.5.X and put ample warning on my web page "use static at
your own risk".

	Jean
