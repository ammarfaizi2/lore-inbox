Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVGVTDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVGVTDQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 15:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVGVTDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 15:03:16 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:52873 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262136AbVGVTDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 15:03:15 -0400
Subject: Re: 2.6.13-rc3-mm1 (ckrm)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: Gerrit Huizenga <gh@us.ibm.com>, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.44.0507221216090.25001-100000@coffee.psychology.mcmaster.ca>
References: <Pine.LNX.4.44.0507221216090.25001-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 22 Jul 2005 20:27:27 +0100
Message-Id: <1122060447.9478.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-07-22 at 12:35 -0400, Mark Hahn wrote:
> I imagine you, like me, are currently sitting in the Xen talk,

Out by a few thousand miles ;)

> and I don't believe they are or will do anything so dumb as to throw away
> or lose information.  yes, in principle, the logic will need to be 

They don't have it in the first place. 

> somewhere, and I'm suggesting that the virtualization logic should
> be in VMM-only code so it has literally zero effect on host-native 
> processes.  *or* the host-native fast-path.

I don't see why you are concerned. If the CKRM=n path is zero impact
then its irrelevant to you. Its more expensive to do a lot of resource
management at the VMM level because the virtualisation engine doesn't
know anything but its getting indications someone wants to be
bigger/smaller.


> but to really do CKRM, you are going to want quite extensive interaction with
> the scheduler, VM page replacement policies, etc.  all incredibly
> performance-sensitive areas.

Bingo - and areas the virtualiser can't see into, at least not unless it
uses the same hooks CKRM uses

Alan

