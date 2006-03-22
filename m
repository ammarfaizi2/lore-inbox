Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWCVGT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWCVGT4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWCVGT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:19:56 -0500
Received: from mail.gmx.de ([213.165.64.20]:29578 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750811AbWCVGTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:19:55 -0500
X-Authenticated: #14349625
Subject: Re: p4-clockmod not working in 2.6.16
From: Mike Galbraith <efault@gmx.de>
To: Edgar Toernig <froese@gmx.de>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060322065714.169ce224.froese@gmx.de>
References: <1142974528.3470.4.camel@localhost>
	 <20060321210106.GA25370@redhat.com> <1142978230.3470.12.camel@localhost>
	 <20060321220115.GA8583@redhat.com>  <20060322065714.169ce224.froese@gmx.de>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 07:20:05 +0100
Message-Id: <1143008405.13748.4.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 06:57 +0100, Edgar Toernig wrote:

> And at last: reading Intel's errata it should be good enough to not go
> below 25% instead limiting all below 2GHz.  I'm not even sure whether
> the 2GHz mentioned there is the reduced or the nominal clock.  Running
> 2GHz on 12.5% would be a really fast CPU.
> 
> | N60.         Processor May Hang under Certain Frequencies and 12.5%
> |              STPCLK# Duty Cycle
> |
> | Problem:     If a system de-asserts STPCLK# at a 12.5% duty cycle, the
> |              processor is running below 2 GHz, and the processor thermal
> |              control circuit (TCC) on-demand clock modulation is active,
> |              the processor may hang. This erratum does not occur under
> |              the automatic mode of the TCC.
> |
> | Implication: When this erratum occurs, the processor will hang.
> |
> | Workaround:  If use of the on-demand mode of the processor's TCC is desired
> |              in conjunction with STPCLK# modulation, then assure that STPCLK#
> |              is not asserted at a 12.5% duty cycle.

Yeah, I read that too, and it looked to me like someone might have used
a bit too mich blunt force.  (not sure though)  I disabled it so I could
save a tree or two, and it seems to work fine.  Of course, if it does
ever have a seizure, I don't get to gripe ;-)

	-Mike

