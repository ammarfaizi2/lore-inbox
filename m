Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264506AbTLEVCP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 16:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264507AbTLEVCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 16:02:14 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:8664 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S264506AbTLEVCM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 16:02:12 -0500
Date: Fri, 5 Dec 2003 13:02:03 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
Cc: cheuche+lkml@free.fr, linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
Message-ID: <20031205210203.GM29119@mis-mike-wstn.matchmail.com>
Mail-Followup-To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
	cheuche+lkml@free.fr, linux-kernel@vger.kernel.org
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F877@mail-sc-6.nvidia.com> <20031205201812.GA10538@localnet> <3FD0EBE6.9080003@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD0EBE6.9080003@gmx.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 09:34:46PM +0100, Prakash K. Cheemplavam wrote:
> Hmm, interesting observation. This makes me remeber something: When my 
> machine freezes doing hdparm, the cursor still blinks, but I can't do 
> anything anymore. Maybe a connection to your observation? I haven't 
> treid to run the NMI watchdog, as you guys haven't had success with it yet.

Everyone with this problem should turn on the nmi_watchdog, as someone may
have the right circumstances to produce an oops where the others didn't.

I say that you're not serious about getting this fixed unless you're going
to do all of:

 o turn on nmi_watchdog
 o try the patches posted[1]
 o contact nvidia or your motherboard manufacturer saying you need linux
   support, and return the board if they don't. (phone, fax, email, or even
   local office if there is one)

I bought a VIA board to avoid the problems I expected from the nforce, and I
needed a system (server) that would *work* now.

[1] If you're worried about your filesystem, just boot the patched kernel in
single mode, and that will mount all of your filesystems read-only so there
will be little chance of corruption.

Mike
