Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268553AbUJDTaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268553AbUJDTaI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 15:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268467AbUJDTYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 15:24:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:10931 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268457AbUJDTPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 15:15:47 -0400
X-Authenticated: #20450766
Date: Mon, 4 Oct 2004 21:11:18 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Paul Jackson <pj@sgi.com>
cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, alan@lxorguk.ukuu.org.uk,
       olaf+list.linux-kernel@olafdietsche.de, george@mvista.com,
       akpm@osdl.org, juhl-lkml@dif.dk, clameter@sgi.com, drepper@redhat.com,
       johnstul@us.ibm.com, Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com,
       Simon.Derr@bull.net
Subject: Re: [OT] Re: patches inline in mail
In-Reply-To: <20041003232033.7790445f.pj@sgi.com>
Message-ID: <Pine.LNX.4.60.0410042108490.3871@poirot.grange>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
 <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
 <41550B77.1070604@redhat.com> <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
 <4159B920.3040802@redhat.com> <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
 <415AF4C3.1040808@mvista.com> <Pine.LNX.4.58.0409291054230.25276@schroedinger.engr.sgi.com>
 <415B0C9E.5060000@mvista.com> <Pine.LNX.4.61.0409292143050.2744@dragon.hygekrogen.localhost>
 <415B4FEE.2000209@mvista.com> <20040930222928.1d38389f.akpm@osdl.org>
 <1096633681.21867.14.camel@localhost.localdomain> <415DD31A.3020004@mvista.com>
 <87vfdtglrx.fsf@goat.bogus.local> <1096730402.25131.18.camel@localhost.localdomain>
 <Pine.LNX.4.60.0410032255360.5054@poirot.grange> <20041003232033.7790445f.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Oct 2004, Paul Jackson wrote:

> Guennadi wrote:
> > However, everybody (not pine-users) complains, that white spaces got 
> > corrupted. And if I export the email I see ...
> 
> I complained about the same extra space to a colleague of mine,
> Simon Derr <Simon.Derr@bull.net>.
> 
> A day later, Simon wrote back to me:
> > I think I found the culprit:
> > pine 4.60 and later have a feature about 'flowed text' that has to be
> > explicitely turned off and that messes with whitespaces.
> 
> And indeed, that fixed his patches, from my perspective.

Thanks to all, who replied. This:

--- .pinerc~	Sat Oct  2 22:59:50 2004
+++ .pinerc	Mon Oct  4 20:13:03 2004
@@ -82,6 +82,7 @@
 	signature-at-bottom,
 	no-pass-control-characters-as-is,
 	prefer-plain-text,
+	quell-flowed-text,
 	slash-collapses-entire-thread,
 	enable-bounce-cmd,
 	enable-msg-view-urls,

helped (I hope).

Thanks
Guennadi
---
Guennadi Liakhovetski

