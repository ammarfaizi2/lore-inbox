Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbTKGWC1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264186AbTKGWBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:01:42 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:32447
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S263961AbTKGJRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 04:17:38 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Linus Torvalds <torvalds@osdl.org>, bill davidsen <davidsen@tmr.com>
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Date: Fri, 7 Nov 2003 03:13:53 -0600
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0311061143300.1842-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0311061143300.1842-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311070313.53958.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 November 2003 13:45, Linus Torvalds wrote:
> On 6 Nov 2003, bill davidsen wrote:
> > I'm not sure what you mean by faster, burning runs at device limited
> > speed in CPU time in the  less than 1% range if you remember to enable
> > DMA. The last time I looked DMA didn't work in either kernel if write
> > size was not a multiple of 1k, (or 2k?) has that changed?
>
> DMA works fine
>
> 	IF YOU DON'T USE IDE-SCSI
>
> Don't use it. Please. There's no point.
>
> It's much more readable to do
>
> 	cdrecord dev=/dev/hdc
>
> than it is to do some stupid "scan SCSI devices" + "dev=0,1,0" or similar
> totally incomprehensible crap that doesn't even work right.
>
> > I'm not sure what you meant by faster, so don't think I'm disagreeing
> > with you.
>
> Faster as in "it uses DMA for everything, so you can actually burn at full
> speed without having to worry about it or sucking up CPU".
>
> 		Linus

Note this still doesn't mean you can scroll large X windows for two or three 
seconds at a time without burning a coaster.

I had high hopes with the new scheduler, but no.  (Maybe if I niced the heck 
out of cdrecord...)

Rob
