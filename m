Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932704AbVJCWFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbVJCWFy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 18:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932708AbVJCWFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 18:05:54 -0400
Received: from amdext3.amd.com ([139.95.251.6]:13722 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S932704AbVJCWFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 18:05:53 -0400
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Date: Mon, 3 Oct 2005 16:22:51 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: AMD Geode GX/LX support
Message-ID: <20051003222251.GG30975@cosmic.amd.com>
References: <20051003174738.GC29264@cosmic.amd.com>
 <1128366109.26992.27.camel@localhost.localdomain>
 <20051003195531.GB30975@cosmic.amd.com>
 <1128372369.26992.48.camel@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <1128372369.26992.48.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F5F74BD354758454-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/05 21:46 +0100, Alan Cox wrote:
> On Llu, 2005-10-03 at 13:55 -0600, Jordan Crouse wrote:
> > As I mentioned in the previous e-mail, the GEODEGX1 define as it stands
> > is incorrect - the cache line size should be 16 bytes for the GX1.  The 
> > GX and LX share a newer core, so it stands, I think that they should have
> > a different define.
> 
> What makes the cores different ? Cache line size ? If they share the
> same kernel options and build then they don't need a new define, the
> existing one just need generalising.

After thinking about this a bit more, I think we should keep the GEODEGX1
define because it was for a different core, but consolidate the GX and LX
defines into a single define.  Originally, we added the defines for
ease-of-use in the configuration realm, for example, not allowing the user to
build the LX TRNG for a GX kernel.  Based on the other comments regarding
similar things, I now think that we should avoid it all together.

I'm going to keep the GEODE_LX define, and send GEODE_GX to the briny deep.
I guess technically, we could use the codename for the core, but I think
that would be more confusing.  Best to stick with the marketing names, I think.

> > I suppose that I should come with something more solid then a gut feeling, 
> > though, substantial as my gut may be.
> 
> Indeed. With gcc 3.x I ended up with -m486 -falign-functions=0 and that
> used to be the settings. I don't know who changed it to pentium-mmx in
> the end but I objected to about four different patches that did this
> over time and people still kept submitting them.

I'll remove the defines for now until we can prove that its better to have 
them turned on.

Thanks for your comments,
Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

