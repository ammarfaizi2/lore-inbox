Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281070AbRKDSSC>; Sun, 4 Nov 2001 13:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281056AbRKDSRv>; Sun, 4 Nov 2001 13:17:51 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:30224 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S281064AbRKDSRl>; Sun, 4 Nov 2001 13:17:41 -0500
Message-Id: <200111041817.fA4IHaY68557@aslan.scsiguy.com>
To: Gregoire Favre <greg@ulima.unil.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel panic: Loop 1 (aic7xxx under 2.4.13-ac[246]) 
In-Reply-To: Your message of "Sun, 04 Nov 2001 14:51:15 +0100."
             <20011104145115.B19746@ulima.unil.ch> 
Date: Sun, 04 Nov 2001 11:17:36 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello,
>
>With 2.4.10-ac7 no problems at all, but with 2.4.13-ac[246] (not tested the ot
>her
>ones), compiled either with gcc-2.96 from Mandrake or gcc-3.02 also from Mandr
>ake,
>on the first power on of my computer, ends so:
>
>scsi0:A:0:0: Tagged Queuing enabled. Depth 64
>scsi1: brkadrint, Scratch or SCB Memory Parity Error at seqaddr = 0x1

I have seen this reported before, but have yet to track it down.
The problem is an access to an uninitialized location in scratch
or SCB ram.  Unfortunately, none of my aic7870 based cards seem
to show the error.  Hopefully my next code review will unveil the
problem.

--
Justin
