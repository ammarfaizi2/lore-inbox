Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbVHEAfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbVHEAfo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 20:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbVHEAfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 20:35:43 -0400
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:24266 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262772AbVHEAfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 20:35:41 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Date: Fri, 5 Aug 2005 10:31:33 +1000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com
References: <200508031559.24704.kernel@kolivas.org> <20050805001244.65f41b4f.Ballarin.Marc@gmx.de>
In-Reply-To: <20050805001244.65f41b4f.Ballarin.Marc@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508051031.33949.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2005 08:12 am, Marc Ballarin wrote:
> On Wed, 3 Aug 2005 15:59:24 +1000
>
> Con Kolivas <kernel@kolivas.org> wrote:
> > This is the dynamic ticks patch for i386 as written by Tony Lindgen
> > <tony@atomide.com> and Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>.
> > Patch for 2.6.13-rc5
>
> One issue (tested the -rc4 Version on -mm):
> - on interrupt flood (ping -f) HZ goes down to 0-4 HZ.
>   This matches "ticks to skip" below. Coincidence?
>
> - ping -f complains:
> .Warning: time of day goes back (-304us), taking countermeasures.
> ...
> .Warning: time of day goes back (-33us), taking countermeasures.
>
> Yet, system time _seems_ to be kept correctly.

Interesting... It almost seems like if you throw enough interrupts at it the 
next_timer_interrupt function gets confused. I wonder if S390 and ARM are 
seeing this at all since (it seems to me) they use that function?

Con
