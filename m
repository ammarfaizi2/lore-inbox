Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVFSBDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVFSBDc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 21:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVFSBDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 21:03:31 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:47050 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S262212AbVFSBD3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 21:03:29 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Andi Kleen <ak@muc.de>
Subject: Re: [2.6.12] x86-64 IO-APIC + timer doesn't work
Date: Sun, 19 Jun 2005 02:03:50 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, ACurrid@nvidia.com
References: <200506181452.52921.s0348365@sms.ed.ac.uk> <20050618190921.GA59126@muc.de>
In-Reply-To: <20050618190921.GA59126@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506190203.50281.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 Jun 2005 20:09, Andi Kleen wrote:
> On Sat, Jun 18, 2005 at 02:52:52PM +0100, Alistair John Strachan wrote:
> > Hi,
> >
> > I upgraded my nForce3 x86-64 desktop from 2.6.12-rc5 to 2.6.12 today and
> > something strange started happening. Waay back in 2.6.x I had problems
> > with the "noapic" default for nForce boards on x86-64, and so used the
> > "apic" kernel boot parameter to force the apic on; this worked
> > successfully for a long time with no timer problems.
>
> apic hasn't been needed for several kernel releases now, since the
> timer override problem on the Nforce has been workarounded.

I figured it out. This workaround has only just been enabled on my board since 
I updated my BIOS from the 1.6 to 1.7 revision. Clearly the workaround's 
"detection" isn't sufficiently vigorous. I can demonstrate 2.6.12 
mis-detecting my nForce3 board with the 1.6 BIOS, and correctly enabling the 
workaround with the 1.7 BIOS.

It's probably not worth fixing, but it might be a useful datapoint in future 
(make sure people with MSI MS-7030 boards update their BIOS).

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
