Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261404AbRE2SqE>; Tue, 29 May 2001 14:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261400AbRE2Spp>; Tue, 29 May 2001 14:45:45 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:35078 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S261379AbRE2Spl>; Tue, 29 May 2001 14:45:41 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: serial console problems under 2.4.4/5
Date: Tue, 29 May 2001 18:45:39 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9f0qoj$ttr$1@ncc1701.cistron.net>
In-Reply-To: <yrxofscdnpj.fsf@terra.mcs.anl.gov>
X-Trace: ncc1701.cistron.net 991161939 30651 195.64.65.67 (29 May 2001 18:45:39 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <yrxofscdnpj.fsf@terra.mcs.anl.gov>,
Narayan Desai <desai@mcs.anl.gov> wrote:
>Hi. I have started having serial console problems in the last bunch of
>kernel releases. I have tried various 2.4.4 and 2.4.5 ac kernels (up
>to and including 2.4.5-ac4) and the problem has persisted. The problem
>is basically that serial console doesn't recieve.

The serial driver now pays attention to the CREAD bit. Sysvinit
clears it, so that's where it goes wrong.

I don't think this change should have gone into a 'stable' kernel
version. 2.5.0 would have been fine, not 2.4.4

Mike.

