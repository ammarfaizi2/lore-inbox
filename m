Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWFMUjC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWFMUjC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 16:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWFMUjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 16:39:01 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:26563 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932229AbWFMUjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 16:39:00 -0400
Date: Tue, 13 Jun 2006 22:38:28 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Mikael Pettersson <mikpe@it.uu.se>, rdunlap@xenotime.net, akpm@osdl.org,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] [2.6.17-rc6] Section mismatch in drivers/net/ne.o during modpost
Message-ID: <20060613203828.GA26690@mars.ravnborg.org>
References: <200606110051.k5B0pLBI010621@harpo.it.uu.se> <10735.1150176929@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10735.1150176929@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Probably over enthusiastic gcc inlining.  gcc 4 will inline functions
> that are not declared as inline.  That is not so bad, except that some
> versions of gcc will ignore a mismatch in function attributes and
> inline a __init function into normal text, generating additional
> section mismatches.
When using -ffunction-sections (or similar) then we ask gcc to put each
function in separate sections. In this case it is OK to mix sections.
But I agree, gcc should not mix user specified sections.

> For a specific example, see
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113824309203482&w=2
That's a good example - thanks!

	Sam
