Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265055AbUGUGHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265055AbUGUGHN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 02:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265154AbUGUGHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 02:07:12 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:21957 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265055AbUGUGHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 02:07:09 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040721000348.39dd3716.akpm@osdl.org>
References: <20040709182638.GA11310@elte.hu>
	 <20040710222510.0593f4a4.akpm@osdl.org>
	 <1089673014.10777.42.camel@mindpipe>
	 <20040712163141.31ef1ad6.akpm@osdl.org>
	 <1089677823.10777.64.camel@mindpipe>
	 <20040712174639.38c7cf48.akpm@osdl.org> <20040719102954.GA5491@elte.hu>
	 <1090380467.1212.3.camel@mindpipe>  <20040721000348.39dd3716.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1090390028.901.40.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 21 Jul 2004 02:07:09 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-21 at 03:03, Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> >  discovered I can reliably produce a large XRUN by toggling Caps Lock, 
> > Scroll Lock, or Num Lock.  This is with 2.6.8-rc1-mm1 + voluntary
> > preempt
> 
> That's odd.  I wonder if the hardware is sick.  What is the duration is the
> underrun?  The info you sent didn't include that.
> 
> > (I modified the patch by hand to apply on this kernel, as
> > 2.6.8-rc2 disables my network card).
> 
> eh?  That's a rather more serious problem.  Does the via-rhine.c from
> 2.6.8-rc1-mm1 work OK if you move it into 2.6.8-rc2?

Yes, the version from 2.6.8-rc1 works, the one from 2.6.8-rc2 does not. 
It looks like 2.6.8-rc1 actually had a newer version of this file.

This one works:

         LK1.2.0-2.6 (Roger Luethi)                                                                                                                                                           
          - Massive clean-up                                                                                                                                                                   
          - Rewrite PHY, media handling (remove options, full_duplex, backoff)                                                                                                                 
          - Fix Tx engine race for good                                                                                                                                                        
                        
This one does not:
  
          LK1.1.19 (Roger Luethi)
          - Increase Tx threshold for unspecified errors

Relevant options:

CONFIG_VIA_RHINE=m
CONFIG_VIA_RHINE_MMIO=y

Lee

