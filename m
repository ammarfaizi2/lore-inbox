Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264782AbUD2TIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264782AbUD2TIW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 15:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264921AbUD2TIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 15:08:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7890 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264782AbUD2TIU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 15:08:20 -0400
Date: Thu, 29 Apr 2004 20:08:18 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Giuliano Colla <copeca@copeca.dsnet.it>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       hsflinux@lists.mbsi.ca, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [hsflinux] [PATCH] Blacklist binary-only modules lying about their	license
Message-ID: <20040429190818.GK17014@parcelfarce.linux.theplanet.co.uk>
References: <408DC0E0.7090500@gmx.net> <40914C35.1030802@copeca.dsnet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40914C35.1030802@copeca.dsnet.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 08:40:53PM +0200, Giuliano Colla wrote:
> As an end user, if I buy a full fledged modem, I get some amount of 
> proprietary, non GPL, code  which executes within the board or the 
> PCMCIA card of the modem. The GPL driver may even support the 
> functionality of downloading a new version of *proprietary* code into 
> the flash Eprom of the device. The GPL linux driver interfaces with it, 
> and all is kosher.
> On the other hand, I have the misfortune of being stuck with a 
> soft-modem, roughly the *same* proprietary code is provided as a binary 
> file, and a linux driver (source provided) interfaces with it. In that 
> case the kernel is flagged as "tainted".
> 
> But in both cases, if the driver is poorly written, because of 
> developer's inadequacy, or because of the proprietary code being poorly 
> documented and/or implemented, my kernel may go nuts, be it tainted or not.
> 
> Can you honestly tell apart the two cases, if you don't make a it a case 
> of "religion war"?

Yes.  *Especially* outside of religious wars - while fuckup capabilities
of Joe Random Driver Monkey are unlimited, there is a difference between
the impact of fuckups in the code that runs on CPU and in the code that
runs on peripherial.  If nothing else, the latter is less likely to try
anything cute and tricky with locking.

In other words, with code running on the host CPU  lusers have much, much
more ways to luse, luse again when trying to "fix" things and make it
harder to figure out what had caused the bloody mess.
