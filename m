Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286601AbRLUV3U>; Fri, 21 Dec 2001 16:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286582AbRLUV3D>; Fri, 21 Dec 2001 16:29:03 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:19980 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S286592AbRLUV2x>; Fri, 21 Dec 2001 16:28:53 -0500
Date: Fri, 21 Dec 2001 22:28:47 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Romano Giannetti <romano@dea.icai.upco.es>, linux-kernel@vger.kernel.org
Subject: Re: User-manageable sub-ids proposals
Message-ID: <20011221222847.B1564@devcon.net>
Mail-Followup-To: Romano Giannetti <romano@dea.icai.upco.es>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <20011207202036.J2274@redhat.com> <20011208155841.A56289@wobbly.melbourne.sgi.com> <3C127551.90305@namesys.com> <20011211134213.G70201@wobbly.melbourne.sgi.com> <5.1.0.14.2.20011211184721.04adc9d0@pop.cus.cam.ac.uk> <3C1678ED.8090805@namesys.com> <20011212204333.A4017@pimlott.ne.mediaone.net> <3C1873A2.1060702@namesys.com> <20011213113616.B6547@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011213113616.B6547@pern.dea.icai.upco.es>; from romano@dea.icai.upco.es on Thu, Dec 13, 2001 at 11:36:16AM +0100
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2001 at 11:36:16AM +0100, Romano Giannetti wrote:
> 
> I was thinking about the idea of sub-ids to enable users to run "untrusted"
> binary or "dangerous" one without risk for their files/privacy. 

Most parts of your proposal can be implemented in userspace, without
any kernel changes.

In fact, most parts /are/ already implemented, and only waiting to be
configured properly. It's called "sudo".

The only deficiency of the userspace only approach I see at the moment
is that you can't impersonate the slave user from the main user id
regarding to filesystem access. This can be worked around with proper
permissions if you take the "one group/one user" approach, all
slave users will have the main users group.

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
