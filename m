Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWDMPAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWDMPAX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 11:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbWDMPAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 11:00:22 -0400
Received: from ns1.idleaire.net ([65.220.16.2]:52685 "EHLO iasrv1.idleaire.net")
	by vger.kernel.org with ESMTP id S1750793AbWDMPAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 11:00:20 -0400
Subject: Re: [RFD][PATCH] typhoon and core sample for folding away VLAN
	stuff
From: Dave Dillow <dave@thedillows.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, Ingo Oeser <netdev@axxeo.de>,
       netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com
In-Reply-To: <200604131138.59611.vda@ilport.com.ua>
References: <200604071628.30486.vda@ilport.com.ua>
	 <200604122132.46113.ioe-lkml@rameria.de> <443DA830.8030209@thedillows.org>
	 <200604131138.59611.vda@ilport.com.ua>
Content-Type: text/plain
Date: Thu, 13 Apr 2006 11:00:14 -0400
Message-Id: <1144940414.29160.14.camel@dillow.idleaire.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Apr 2006 14:59:41.0960 (UTC) FILETIME=[E4CD2880:01C65F0A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-13 at 11:38 +0300, Denis Vlasenko wrote:
> On Thursday 13 April 2006 04:24, Dave Dillow wrote:
> > Regardless, I remain opposed to this particular instance of bloat 
> > busting. While both patches have improved in style, they remove a useful 
> > feature and make the code less clean, for no net gain.
> 
> What happened to non-modular build? "no net gain" is not true.

Ok, so you saved what, 200 bytes? On a few drivers that may save you a
small amount -- you basically said you had to have everything loaded to
see 5K.

Weren't most of those savings from moving a big function out-of-line?
The part I agree with?
 
> > > This kind of changes are important, because bloat creeps in byte by byte
> > > of unused features. So I really appreciate your work here Denis.
> > 
> > On SMP FC4, typhoon.ko has a text size of 68330, so you need to cut 2794 
> > bytes to see an actual difference in memory usage for a module. Non-SMP 
> > it is 67741, so there you only need to cut 2205 bytes to get a win.
> 
> This is silly. Should I go this route and try a dozen of different gcc
> versions and "-O2 versus -Os" things to demonstrate that sometimes
> it will matter?

Quit being dense. No one has said that there are cases will it make a
difference, just that that case is far removed from the usual case.

I think I'm done on this topic. You've got more important people to
convince than me, and they've already clear stated their position.
-- 
Dave Dillow <dave@thedillows.org>

