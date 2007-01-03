Return-Path: <linux-kernel-owner+w=401wt.eu-S1753720AbXACCVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720AbXACCVi (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 21:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753703AbXACCVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 21:21:38 -0500
Received: from aun.it.uu.se ([130.238.12.36]:45906 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753690AbXACCVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 21:21:37 -0500
Date: Wed, 3 Jan 2007 03:12:13 +0100 (MET)
Message-Id: <200701030212.l032CDXe015365@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: s0348365@sms.ed.ac.uk, torvalds@osdl.org
Subject: Re: kernel + gcc 4.1 = several problems
Cc: 76306.1226@compuserve.com, akpm@osdl.org, bunk@stusta.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, yanmin_zhang@linux.intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2007 17:43:00 -0800 (PST), Linus Torvalds wrote:
> > The suggestions I've had so far which I have not yet tried:
> > 
> > -	Select a different x86 CPU in the config.
> > 		-	Unfortunately the C3-2 flags seem to simply tell GCC
> > 			to schedule for ppro (like i686) and enabled MMX and SSE
> > 		-	Probably useless
> 
> Actually, try this one. Try using something that doesn't like "cmov". 
> Maybe the C3-2 simply has some internal cmov bugginess. 

That's a good suggestion. Earlier C3s didn't have cmov so it's 
not entirely unlikely that cmov in C3-2 is broken in some cases.
Configuring for P5MMX or 486 should be good safe alternatives.

/Mikael
