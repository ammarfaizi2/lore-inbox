Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265246AbUETUte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265246AbUETUte (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 16:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbUETUte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 16:49:34 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:37650 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S265246AbUETUtc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 16:49:32 -0400
Date: Thu, 20 May 2004 14:49:20 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Etienne Vogt <etienne.vogt@obspm.fr>, linux-kernel@vger.kernel.org
Subject: Re: aic79xx trouble
Message-ID: <320270000.1085086159@aslan.btc.adaptec.com>
In-Reply-To: <20040520203004.GD20953@logos.cnet>
References: <200405132125.28053.bernd.schubert@pci.uni-heidelberg.de> <200405132136.32703.bernd.schubert@pci.uni-heidelberg.de> <Pine.LNX.4.58.0405161930260.2851@siolinb.obspm.fr> <3436150000.1084731012@aslan.btc.adaptec.com> <20040520203004.GD20953@logos.cnet>
X-Mailer: Mulberry/3.1.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, May 16, 2004 at 12:10:12PM -0600, Justin T. Gibbs wrote:
>> >  The Adaptec Ultra320 cards (aic79xx) do not work reliably on Tyan Thunder
>> > motherboards.
>> 
>> The U320 chips likely work a lot better now if you use driver version 2.0.12.
>> The AMD chipsets seem to screw up split completions, and this version of
>> the driver avoids the issue for the most common case of triggering the
>> bug (transaction completion DMAs) by never crossing an ADB boundary with
>> a single DMA.
> 
> Justin, 
> 
> Just out of curiosity, would you care to submit small fixes in separate
> patches instead of a huge patch over a full -pre series 
> (2.4.28-pre for example) ? 

If you look at the bksend output from my site, it is broken up into
lots of smaller changes.  These changes are not tied to a particular
2.4.X revision - they were made and released in response to driver
bug reports and coded so the driver will operate in just about any
2.4.X kernel - customers can't wait for the next kernel to be
released or the community to enter a "pre" phase of development.

As for submitting "small fixes in separate patches", the fixes are
whatever size they come out to be after they are implemented.  I
always choose the fix based on correctness and maintainability, not
on whether or not I can break it up into small patches for submission.
In other-words, the size of the changes have nothing to do with their
merit.

What it seems you are asking for is more frequent submissions.
While that is possible, I don't know that it is in the best interest
of the community.  I submit a new update to kernel.org after changes
have had a time to settle and have been validated by Adaptec and
several of its customers.  Unless the failure is going to be seen
in wide-spread use and the fix is so obvious that it does not need
rigorous validation, I prefer to wait and submit a known quantity.
The latest drivers on my website have had a sufficient level of
testing for me to now feel comfortable with pushing the changes to
kernel.org.

> Are distros using your updates ?

I believe that SuSE is merging these drivers into their next 2.6.X
based release.

--
Justin

