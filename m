Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWETTLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWETTLF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 15:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWETTLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 15:11:04 -0400
Received: from smtp.bulldogdsl.com ([212.158.248.7]:19474 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1750788AbWETTLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 15:11:03 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ayaz Abdulla <aabdulla@nvidia.com>
Subject: Re: Linux v2.6.17-rc4
Date: Sat, 20 May 2006 20:11:11 +0100
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jeff@garzik.org, netdev@vger.kernel.org,
       Manfred Spraul <manfred@colorfullife.com>
References: <Pine.LNX.4.64.0605111640010.3866@g5.osdl.org> <4466E2E8.7090801@nvidia.com> <200605150627.19498.s0348365@sms.ed.ac.uk>
In-Reply-To: <200605150627.19498.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605202011.11685.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 May 2006 06:27, Alistair John Strachan wrote:
> On Sunday 14 May 2006 08:57, Ayaz Abdulla wrote:
> > Alistair John Strachan wrote:
>
> [snip]
>
> > > There's been just a single commit since -rc3:
> > >
> > > forcedeth: fix multi irq issues
> > > ebf34c9b6fcd22338ef764b039b3ac55ed0e297b
> > >
> > > However, it could have just been hidden since before -rc3, so I'll try
> > > to work backwards if nobody has any immediate ideas..
> >
> > The interrupt handler could be called during the same time (on different
> > cpu) the dev->stop function is clearing out the rings (nv_txrx_reset).
>
> FWIW, I can't reproduce the fault with the commitdiff
> ebf34c9b6fcd22338ef764b039b3ac55ed0e297b reverted.

Manfred located the fault and Andrew's holding a fix for it in -mm. Hopefully 
it'll end up in mainline before 2.6.17.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
