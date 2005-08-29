Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbVH2P5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbVH2P5y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 11:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbVH2P5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 11:57:54 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:14021 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751063AbVH2P5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 11:57:53 -0400
Date: Mon, 29 Aug 2005 10:57:50 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, John Rose <johnrose@austin.ibm.com>,
       akpm@osdl.org, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch 8/8] PCI Error Recovery: PPC64 core recovery routines
Message-ID: <20050829155750.GB12618@austin.ibm.com>
References: <20050823231817.829359000@bilge> <20050823232143.003048000@bilge> <20050823234747.GI18113@austin.ibm.com> <1124898331.24668.33.camel@sinatra.austin.ibm.com> <20050824162959.GC25174@austin.ibm.com> <17165.3205.505386.187453@cargo.ozlabs.ibm.com> <1124930943.5159.168.camel@gaston> <20050825162118.GH25174@austin.ibm.com> <1125006237.12539.23.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125006237.12539.23.camel@gaston>
User-Agent: Mutt/1.5.9i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2005 at 07:43:57AM +1000, Benjamin Herrenschmidt was heard to remark:
> On Thu, 2005-08-25 at 11:21 -0500, Linas Vepstas wrote:
> > On Thu, Aug 25, 2005 at 10:49:03AM +1000, Benjamin Herrenschmidt was heard to remark:
> > > 
> > > Of course, we'll possibly end up with a different ethX or whatever, but
> > 
> > Yep, but that's not an issue, since all the various device-naming
> > schemes are supposed to be fixing this. Its a distinct problem;
> > it needs to be solved even across cold-boots. 
> 
> Ok, so what is the problem then ? Why do we have to wait at all ? Why
> not just unplug/replug right away ?

Paranoia + old versions of udev. I beleive that older versions of udev
(such as the ones currently shipping with Red Hat RHEL4 and SuSE SLES9)
failed to serialize events properly.  I beleive that the newer versions
do serialize, but have not verified/tested.

--linas

