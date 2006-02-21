Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWBUUFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWBUUFq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 15:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWBUUFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 15:05:46 -0500
Received: from ns2.suse.de ([195.135.220.15]:50891 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964778AbWBUUFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 15:05:46 -0500
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: softlockup interaction with slow consoles
Date: Tue, 21 Feb 2006 21:05:37 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
References: <Pine.LNX.4.58.0602210404330.3092@devserv.devel.redhat.com> <p73mzgk4y9u.fsf@verdi.suse.de> <20060221.120143.15763934.davem@davemloft.net>
In-Reply-To: <20060221.120143.15763934.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602212105.38075.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 February 2006 21:01, David S. Miller wrote:
> From: Andi Kleen <ak@suse.de>
> Date: 21 Feb 2006 14:49:49 +0100
> 
> > Still you could probably see problems with very slow consoles even
> > after bootup, couldn't you?
> 
> Yes, others have mentioned this too, good point.
> 
> Depending upon what we're really trying to achieve with the
> softlockup stuff, we can perhaps look into increasing the
> timeout or making it configurable.  We could even do this
> dynamically, so when we register a serial console running
> at some low baud rate, we scale up the softlockup timeout
> or something like that.

The classic way is to just use touch_nmi_watchdog() somewhere
in the loop that does work. That touches the softwatchdog too
these days.

-Andi

 
