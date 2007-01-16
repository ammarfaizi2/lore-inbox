Return-Path: <linux-kernel-owner+w=401wt.eu-S1751137AbXAPURR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbXAPURR (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 15:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbXAPURR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 15:17:17 -0500
Received: from mailmxout.mailmx.agnat.pl ([193.239.44.238]:3383 "EHLO
	mailmxout.mailmx.agnat.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbXAPURQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 15:17:16 -0500
From: Arkadiusz Miskiewicz <arekm@maven.pl>
Organization: SelfOrganizing
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives (k8 cpu errata needed?)
Date: Tue, 16 Jan 2007 21:16:37 +0100
User-Agent: KMail/1.9.5
Cc: Robert Hancock <hancockr@shaw.ca>,
       Christoph Anton Mitterer <calestyo@scientia.net>,
       linux-kernel@vger.kernel.org, knweiss@gmx.de, ak@suse.de,
       andersen@codepoet.org, krader@us.ibm.com, lfriedman@nvidia.com,
       linux-nforce-bugs@nvidia.com
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <45ACE07D.3050207@shaw.ca> <20070116180154.GA1335@tuatara.stupidest.org>
In-Reply-To: <20070116180154.GA1335@tuatara.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701162116.37409.arekm@maven.pl>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 January 2007 19:01, Chris Wedgwood wrote:
> On Tue, Jan 16, 2007 at 08:26:05AM -0600, Robert Hancock wrote:
> > >If one use iommu=soft the sata_nv will continue to use the new code
> > >for the ADMA, right?
> >
> > Right, that shouldn't affect it.
>
> right now i'm thinking if we can't figure out which cpu/bios
> combinations are safe we might almost be better off doing iommu=soft
> for *all* k8 stuff except for those that are whitelisted; though this
> seems extremely drastic
>
> it's not clear if this only affect nvidia based chipsets, the nature
> of the corruption makes me think it's not an iommu software bug (we
> see a few bytes not entire pages corrupted, it's not even clear if
> it's entire cachelines trashed) --- perhaps other vendors have more
> recent bios errata or maybe it's just that nvidia has sold a lot of
> these so they are more visible? (i'm assuming at this point it might
> be some kind of cpu errata that some bioses deal with because some
> mainboards don't ever seem to see this whilst others do)

FYI it seems that I was also hit by this bug with qlogic fc card + adaptec 
taro raid controller on Thunder K8SRE S2891 mainboard with nvidia chipset on 
it.

http://groups.google.com/group/fa.linux.kernel/browse_thread/thread/b8bdbde9721f7d35/45701994c95fe2cf?lnk=st&q=arkadiusz+fibre&rnum=8#45701994c95fe2cf


-- 
Arkadiusz Mi¶kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
