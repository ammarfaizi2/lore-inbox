Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161001AbVLHG1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbVLHG1y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 01:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbVLHG1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 01:27:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19145 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030472AbVLHG1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 01:27:53 -0500
Date: Thu, 8 Dec 2005 01:27:21 -0500
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: for_each_online_cpu broken ?
Message-ID: <20051208062721.GE28201@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
References: <20051208050738.GE24356@redhat.com> <20051208052632.GF11190@wotan.suse.de> <20051208053302.GA28201@redhat.com> <20051207.213825.27890558.davem@davemloft.net> <20051208061211.GG11190@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051208061211.GG11190@wotan.suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 07:12:12AM +0100, Andi Kleen wrote:
 > On Wed, Dec 07, 2005 at 09:38:25PM -0800, David S. Miller wrote:
 > > From: Dave Jones <davej@redhat.com>
 > > Date: Thu, 8 Dec 2005 00:33:02 -0500
 > > 
 > > > On Thu, Dec 08, 2005 at 06:26:32AM +0100, Andi Kleen wrote:
 > > > 
 > > >  > The possible map is fixed kind of BTW in 2.6.15rc*. It was a side effect
 > > >  > of CPU hotplug, which now uses a better algorithm to guess the 
 > > >  > number of possible CPUs. In 2.6.15 you will just get half the number
 > > >  > of available CPUs in addition by default
 > > > 
 > > > Yep, I noticed it offers a maximum of 6 cpus on my way.
 > > > As a sidenote, seems kinda funny (and wasteful maybe?), doing this
 > > > on a lot of hardware that isn't hotplug capable. (Whilst I could
 > > > disable cpu hotplug in my local build, this isn't an answer for
 > > > a generic distro kernel).
 > 
 > If you can figure out a way to detect this please share.
 > The ACPI designers unfortunately didn't think that far
 > (they did it right for memory hotplug, but not for CPU) 
 > 
 > I invented an ACPI extensin for it, but it's non standard
 > so the half of CPUs is used as a default unless overwritten
 > (additional_cpus=NUM) 
 > 
 > Anyways I changed it earlier to 1 additional CPU by default.

Just guessing seems to be pretty guaranteed to give the wrong answer.
I think it makes more sense to say "if your BIOS doesn't give
the relevant info (as is usually the case), boot with additional_cpus)

Penalising the many for the needs of the few just seems wrong.
		
		Dave

