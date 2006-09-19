Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWISDh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWISDh4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 23:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWISDh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 23:37:56 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:60826 "EHLO
	asav11.insightbb.com") by vger.kernel.org with ESMTP
	id S1751080AbWISDhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 23:37:55 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FABUCD0WBT4oSLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Repeatable hang on boot with PCMCIA card present
Date: Mon, 18 Sep 2006 23:37:52 -0400
User-Agent: KMail/1.9.3
Cc: Steve Smith <tarka@internode.on.net>, linux-kernel@vger.kernel.org
References: <20060916050331.GA6685@lucretia.remote.isay.com.au> <20060918190902.d5b6a698.akpm@osdl.org>
In-Reply-To: <20060918190902.d5b6a698.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609182337.52990.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 September 2006 22:09, Andrew Morton wrote:
> On Sat, 16 Sep 2006 15:03:31 +1000
> tarka@internode.on.net (Steve Smith) wrote:
> 
> > [I sent the following to the person responsible for the patch but
> > haven't heard anything so I assume he's unavailable...]
> > 
> > Hi,
> > 
> > With recent kernel releases I have started seeing consistent hangs
> > during boot when a PCMCIA card is present in the slot (the card in
> > question is a Linksys wireless-B card).  The symptoms are:
> > 
> >     If the card is present during boot an error of "Unknown interrupt
> >     or fault at EIP ..." appears.
> > 
> >     If the card is not present there is no error.
> > 
> >     The card can be plugged-in post-boot without problems.
> > 
> > Using git-bisect I have narrowed down the error to one commit, namely
> > "use bitfield instead of p_state and state".  The commit# is
> > 
> >     e2d4096365e06b9a3799afbadc28b4519c0b3526
> >
> > However I am still seeing this problem with the latest -RC releases.
> 
> Thanks for doing that.
> 
> Damn, that was a huge patch.  Have you been able to grab
> a copy of the oops output?  It would really help.  Even a photo of
> the screen..
> 

Hmm, not sure why you CCed me unless you remembered I have Inspiron 8100.
What chipset does that Linksys card use? I just tried one of my PCMCIA
cards with orinoco_cs and it booted fine on today's pull from Linus...
 
-- 
Dmitry
