Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264584AbUFCOnC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264584AbUFCOnC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 10:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUFCOis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 10:38:48 -0400
Received: from mail009.syd.optusnet.com.au ([211.29.132.64]:62593 "EHLO
	mail009.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264850AbUFCO2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 10:28:06 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: why swap at all?
Date: Fri, 4 Jun 2004 00:27:57 +1000
User-Agent: KMail/1.6.1
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
References: <1086154721.2275.2.camel@localhost.localdomain> <200406021759.i52Hx00N022255@turing-police.cc.vt.edu> <40BF3329.9040700@tmr.com>
In-Reply-To: <40BF3329.9040700@tmr.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406040027.57481.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2004 00:18, Bill Davidsen wrote:
> Valdis.Kletnieks@vt.edu wrote:
> > On Wed, 02 Jun 2004 07:38:41 +0200, FabF said:
> >>>Yes but: your wm is so  often used/activated it will not get swaped 
> >>> out. But if your mouse passes over mozilla and tries to focus it, then
> >>> you will feel the pain of a swapped-out x program.
> >>
> >>Exactly !
> >>Does autoregulated VM swap. patch could help here ?
> >
> > Con's auto-adjusting swappiness patch did in fact help that quite a bit,
> > especially for the case of heavy file I/O causing process images to be
> > swapped out.  I need to do some comparisons of that to Nick's MM work...
>
> I haven't had a chance to try Con's stuff, the Nick patch is working
> VERY well for me, small memory and slow system, lots of memory pressure.
> Hopefully you can report a comparison.

Well note there are two revisions available now. The original linear design is 
here:
http://ck.kolivas.org/patches/2.6/2.6.7-rc2/patch-2.6.7-rc2-am11

and there is an exponential curve bias in this one which will probably 
deprecate the last one:
http://ck.kolivas.org/patches/2.6/2.6.7-rc2/patch-2.6.7-rc2-as

I am keen to get more feedback; apart from what I get off list there has been 
very little in the way of reports.

Con
