Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276286AbRI1UPL>; Fri, 28 Sep 2001 16:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276288AbRI1UPB>; Fri, 28 Sep 2001 16:15:01 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:43491 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S276286AbRI1UOr>; Fri, 28 Sep 2001 16:14:47 -0400
Message-ID: <8FB7D6BCE8A2D511B88C00508B68C2081971D8@orsmsx102.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com
Cc: padraig@antefacto.com, linux-kernel@vger.kernel.org
Subject: RE: CPU frequency shifting "problems"
Date: Thu, 27 Sep 2001 18:24:56 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Thursday, September 27, 2001 5:56 PM
> To: torvalds@transmeta.com
> Cc: padraig@antefacto.com; linux-kernel@vger.kernel.org
> Subject: Re: CPU frequency shifting "problems"
> Importance: High
> 
> 
> > For example, the Intel "SpeedStep" CPU's are completely broken under
> > Linux, and real-time will advance at different speeds in DC 
> and AC modes,
> > because Intel actually changes the frequency of the TSC 
> _and_ they don't
> > document how to figure out that it changed.
> 
> The change is APM or ACPI initiated. Intel won't tell anyone anything
> useful but Microsoft have published some of the required 
> intel confidential
> information which helps a bit

APM is a lost cause, but the correct solution for ACPI systems is to use the
PM timer. This totally obviates the need to really care about the CPU's
effective frequency at all. Even if you knew all the details of SpeedStep
(and I've seen the same MS doc you have Alan and was surprised at its
detail) you'd still be hosed if the CPU throttles...you'd be hosed in a
*good* way because at least any delays would be longer (not shorter) than
expected but your times would be off nonetheless.

Regards -- Andy
