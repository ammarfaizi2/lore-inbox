Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbVH2QAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbVH2QAd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 12:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVH2QAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 12:00:32 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:20714 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751243AbVH2QAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 12:00:32 -0400
Date: Mon, 29 Aug 2005 11:00:14 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, John Rose <johnrose@austin.ibm.com>,
       akpm@osdl.org, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch 8/8] PCI Error Recovery: PPC64 core recovery routines
Message-ID: <20050829160014.GC12618@austin.ibm.com>
References: <20050823232143.003048000@bilge> <20050823234747.GI18113@austin.ibm.com> <1124898331.24668.33.camel@sinatra.austin.ibm.com> <20050824162959.GC25174@austin.ibm.com> <17165.3205.505386.187453@cargo.ozlabs.ibm.com> <1124930943.5159.168.camel@gaston> <20050825162118.GH25174@austin.ibm.com> <1125006237.12539.23.camel@gaston> <17166.20904.543484.435446@cargo.ozlabs.ibm.com> <1125013056.14185.0.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125013056.14185.0.camel@gaston>
User-Agent: Mutt/1.5.9i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2005 at 09:37:36AM +1000, Benjamin Herrenschmidt was heard to remark:
> On Fri, 2005-08-26 at 09:18 +1000, Paul Mackerras wrote:
> > Benjamin Herrenschmidt writes:
> > 
> > > Ok, so what is the problem then ? Why do we have to wait at all ? Why
> > > not just unplug/replug right away ?
> > 
> > We'd have to be absolutely certain that the driver could not possibly
> > take another interrupt or try to access the device on behalf of the
> > old instance of the device by the time it returned from the remove
> > function.  I'm not sure I'd trust most drivers that far...
> 
> Hrm... If a driver gets that wrong, then it will also blow up when
> unloaded as a module. 


:)  We've discovered two, so far, that blow up when unloaded: 
    lpfc and e1000. I beleive these are now fixed in mainline.

--linas
