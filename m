Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbUL3SRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbUL3SRT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 13:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUL3SRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 13:17:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:11461 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261692AbUL3SRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 13:17:15 -0500
Date: Thu, 30 Dec 2004 10:16:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Jesse Allen <the3dfxdude@gmail.com>, Mike Hearn <mh@codeweavers.com>,
       Thomas Sailer <sailer@scs.ch>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0412301012280.22893@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> 
 <20041120214915.GA6100@tesore.ph.cox.net>  <41A251A6.2030205@wanadoo.fr> 
 <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>  <1101161953.13273.7.camel@littlegreen>
  <1104286459.7640.54.camel@gamecube.scs.ch>  <1104332559.3393.16.camel@littlegreen>
  <Pine.LNX.4.58.0412291047120.2353@ppc970.osdl.org> 
 <53046857041229114077eb4d1d@mail.gmail.com>  <Pine.LNX.4.58.0412291151080.2353@ppc970.osdl.org>
 <530468570412291343d1478cf@mail.gmail.com> <Pine.LNX.4.58.0412291622560.2353@ppc970.osdl.org>
 <Pine.LNX.4.58.0412291703400.30636@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0412291745470.2353@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292050550.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292055540.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292106400.454@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0412292256350.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Dec 2004, Davide Libenzi wrote:
> 
> This might explain what they were seeing, but OTOH it seems that the real 
> cause of their problems is related to something else (according to other 
> emails on this thread).

There's two different problems: the one seen by Thomas (the Xilinx FPGA
synthesizer), which is apparently just due to Wine (or, more likely, the
Windows app itself) depending on a certain memory layout for the stack
and/or other allocations. That one I think we can consider solved, and
indeed had nothing to do with TF.

The other one is the copy-protection code breaking for some game 
(Warcraft) for Jesse Allen, and that one is definitely TF-related.. Jesse 
can fix it with patches, but those patches aren't acceptable for other 
uses, so that's why I'm trying to find something that DTRT both for Wine 
and for a regular debugging session..

		Linus
