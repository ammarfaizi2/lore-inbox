Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262610AbVEMXRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbVEMXRX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 19:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbVEMXQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 19:16:17 -0400
Received: from hummeroutlaws.com ([12.161.0.3]:13838 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S262481AbVEMXOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 19:14:50 -0400
Date: Fri, 13 May 2005 19:14:19 -0400
From: Jim Crilly <jim@why.dont.jablowme.net>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: "Richard F. Rebel" <rrebel@whenu.com>, Andi Kleen <ak@muc.de>,
       Gabor MICSKO <gmicsko@szintezis.hu>, linux-kernel@vger.kernel.org
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050513231419.GP27568@mail>
Mail-Followup-To: "Barry K. Nathan" <barryn@pobox.com>,
	"Richard F. Rebel" <rrebel@whenu.com>, Andi Kleen <ak@muc.de>,
	Gabor MICSKO <gmicsko@szintezis.hu>, linux-kernel@vger.kernel.org
References: <1115963481.1723.3.camel@alderaan.trey.hu> <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com> <20050513191443.GN27568@mail> <20050513201840.GB7436@ip68-225-251-162.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513201840.GB7436@ip68-225-251-162.oc.oc.cox.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/13/05 01:18:40PM -0700, Barry K. Nathan wrote:
> On Fri, May 13, 2005 at 03:14:43PM -0400, Jim Crilly wrote:
> > And what if you have more than one physical HT processor? AFAIK there's no
> > way to disable HT and still run SMP at the same time.
> 
> Actually, there is; read my post earlier in this thread:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111598859708620&w=2
> 
> To elaborate on the "check dmesg" part of that e-mail:
> 
> After you reboot with "maxcpus=2" (or however many physical CPU's you
> have), you need to make sure you have messages like this, which indicate
> that it really worked:
> 
> WARNING: No sibling found for CPU 0.
> WARNING: No sibling found for CPU 1.
> 
> (and so on, if you have more than 2 CPU's)

But what about machines that don't enumerate physical processors before
logical? The comment in setup.c implies that the order that the BIOS
presents CPUs is undefined and if you're unlucky enough to have a machine
that presents the CPUs as physical, logical, physical, logical, etc you're
screwed.

Jim.
