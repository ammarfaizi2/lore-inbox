Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268575AbUIQIko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268575AbUIQIko (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 04:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268576AbUIQIko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 04:40:44 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:50056 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S268575AbUIQIkm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 04:40:42 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 17 Sep 2004 10:23:47 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Michael Hunold <hunold@linuxtv.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] v4l/dvb: cx88 driver update
Message-ID: <20040917082347.GB16344@bytesex>
References: <20040916094323.GA11601@bytesex> <20040916160835.4a6cea02.akpm@osdl.org> <414A862F.5030200@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414A862F.5030200@linuxtv.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 08:37:35AM +0200, Michael Hunold wrote:
> Hi,
> 
>  On 17.09.2004 01:08, Andrew Morton wrote:
> >Gerd Knorr <kraxel@bytesex.org> wrote:
> 
> >>This is a major update of the cx88 driver.
> 
> >drivers/media/video/cx88/cx88-dvb.c:215: `FE_UNREGISTER' undeclared (first 
> >use in this function)

Whoops.  That wasn't intentional ...

> Gerd's latest patch depends on my not-yet-submitted patches, so just 
> simply drop this one. Gerd and I are going to coordinate this and 
> resubmit it again. Ok, Gerd?

I have a (temporary) #define for FE_(UN)REGISTER in there to relax the
dependencies between cx88 + dvb core a bit.  That way it is only a
runtime dependency and only for the dvb part of the cx88 driver.

Unfortunaly the #define catched only one of the two cases where it is
needed, and I didn't notice the second one as I'm working with a
dvb-patched kernel to actually test the stuff ...

Whats your planned timeframe for submitting the dvb updates?  I'd love
to see a working cx88 dvb driver in 2.6.9.

  Gerd

-- 
return -ENOSIG;
