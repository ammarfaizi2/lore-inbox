Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVEOXKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVEOXKQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 19:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVEOXKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 19:10:16 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:21182 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261152AbVEOXKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 19:10:10 -0400
Subject: Re: Hyper-Threading Vulnerability
From: Lee Revell <rlrevell@joe-job.com>
To: Dave Jones <davej@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Matt Mackall <mpm@selenic.com>,
       Andy Isaacson <adi@hexapodia.org>, Andi Kleen <ak@muc.de>,
       "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu
In-Reply-To: <20050515225537.GA22594@redhat.com>
References: <1116089068.6007.13.camel@laptopd505.fenrus.org>
	 <1116093396.9141.11.camel@mindpipe>
	 <1116093694.6007.15.camel@laptopd505.fenrus.org>
	 <1116098504.9141.31.camel@mindpipe>
	 <1116100126.6007.17.camel@laptopd505.fenrus.org>
	 <1116114052.9141.38.camel@mindpipe>
	 <1116142233.6270.9.camel@laptopd505.fenrus.org>
	 <1116189693.17990.1.camel@localhost.localdomain>
	 <1116190107.6270.34.camel@laptopd505.fenrus.org>
	 <1116191459.10653.16.camel@mindpipe>  <20050515225537.GA22594@redhat.com>
Content-Type: text/plain
Date: Sun, 15 May 2005 19:10:09 -0400
Message-Id: <1116198609.25898.22.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-15 at 18:55 -0400, Dave Jones wrote:
> On Sun, May 15, 2005 at 05:10:59PM -0400, Lee Revell wrote:
>  > On Sun, 2005-05-15 at 22:48 +0200, Arjan van de Ven wrote:
>  > > On Sun, 2005-05-15 at 21:41 +0100, Alan Cox wrote:
>  > > > On Sul, 2005-05-15 at 08:30, Arjan van de Ven wrote:
>  > > > > stop entirely.... (and that is also happening more and more and linux is
>  > > > > getting more agressive idle support (eg no timer tick and such patches)
>  > > > > which will trigger bios thresholds for this even more too.
>  > > > 
>  > > > Cyrix did TSC stop on halt a long long time ago, back when it was worth
>  > > > the power difference.
>  > > 
>  > > With linux going to ACPI C2 mode more... tsc is defined to halt in C2...
>  > 
>  > JACK doesn't care about any of this now, the behavior when you
>  > suspend/resume with a running jackd is undefined.  Eventually we should
>  > handle it, but there's no point until the ALSA drivers get proper
>  > suspend/resume support.
> 
> suspend/resume are S states, not C states. C states are occuring
> during runtime.

It should never go into C2 if jackd is running, because you're getting
interrupts from the audio interface at least every 100ms or so (usually
much more often) which will wake up jackd and any clients.

Lee

