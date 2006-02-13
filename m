Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWBMFiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWBMFiT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 00:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWBMFiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 00:38:19 -0500
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:64401 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750877AbWBMFiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 00:38:19 -0500
From: Con Kolivas <kernel@kolivas.org>
To: MIke Galbraith <efault@gmx.de>
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
Date: Mon, 13 Feb 2006 16:37:42 +1100
User-Agent: KMail/1.9.1
Cc: Lee Revell <rlrevell@joe-job.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, gcoady@gmail.com,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com> <200602131605.17198.kernel@kolivas.org> <1139808766.7642.12.camel@homer>
In-Reply-To: <1139808766.7642.12.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602131637.43335.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 16:32, MIke Galbraith wrote:
> On Mon, 2006-02-13 at 16:05 +1100, Con Kolivas wrote:
> > On Monday 13 February 2006 15:59, MIke Galbraith wrote:
> > > Now, let's see if we can get your problem fixed with something that can
> > > possibly go into 2.6.16 as a bugfix.  Can you please try the below?
> >
> > These sorts of changes definitely need to pass through -mm first... and
> > don't forget -mm looks quite different to mainline.
>
> I'll leave that up to Ingo of course, and certainly have no problem with
> them burning in mm.  However, I must say that I personally classify
> these two changes as being trivial and obviously correct enough to be
> included in 2.6.16.  

This part I agree with:
-               } else
-                       requeue_task(next, array);
+               }

The rest changes behaviour; it's not a "bug" so needs testing, should be a 
separate patch from this part, and modified to suit -mm.

Cheers,
Con
