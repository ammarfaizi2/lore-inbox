Return-Path: <linux-kernel-owner+w=401wt.eu-S1751321AbXAUSkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbXAUSkh (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 13:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbXAUSkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 13:40:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:38288 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751314AbXAUSkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 13:40:36 -0500
X-Authenticated: #5039886
Date: Sun, 21 Jan 2007 19:40:32 +0100
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@garzik.org>,
       Chr <chunkeey@web.de>, Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org, htejun@gmail.com, jens.axboe@oracle.com,
       lwalton@real.com
Subject: Re: SATA exceptions with 2.6.20-rc5
Message-ID: <20070121184032.GA3220@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@garzik.org>,
	Chr <chunkeey@web.de>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	linux-kernel@vger.kernel.org, htejun@gmail.com,
	jens.axboe@oracle.com, lwalton@real.com
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <200701191505.33480.s0348365@sms.ed.ac.uk> <45B18160.9020602@shaw.ca> <200701202332.58719.chunkeey@web.de> <45B2C6E1.9000901@shaw.ca> <45B2DF43.8080304@garzik.org> <20070121045437.GA7387@atjola.homenet> <45B30A98.3030206@shaw.ca> <20070121083618.GA2434@atjola.homenet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20070121083618.GA2434@atjola.homenet>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2007.01.21 09:36:18 +0100, Björn Steinbrink wrote:
> On 2007.01.21 00:39:20 -0600, Robert Hancock wrote:
> > Björn Steinbrink wrote:
> > >On 2007.01.20 22:34:27 -0500, Jeff Garzik wrote:
> > >>Robert Hancock wrote:
> > >>>change in 2.6.20-rc is either causing or triggering this problem. It 
> > >>>would be useful if you could try git bisect between 2.6.19 and 
> > >>>2.6.20-rc5, keeping the latest sata_nv.c each time, and see if that 
> > >>
> > >>Yes, 'git bisect' would be the next step in figuring out this puzzle.
> > >>
> > >>Anybody up for it?
> > >
> > >I'll go for it, but could I get an explanation how that could lead to a
> > >different result than my last bisection? I see the difference of keeping
> > >sata_nv.c but my brain can't wrap around it right now (woke up in the
> > >middle of the night and still not up to speed...).
> > 
> > Whatever the problem is, only seems to show up when ADMA is enabled, and 
> > so the patch that added ADMA support shows up as the culprit from your 
> > git bisect. However, from what Chr is reporting, 2.6.19 with the ADMA 
> > support added in doesn't seem to have the problem, so presumably 
> > something else that changed in the 2.6.20-rc series is triggering it. 
> > Doing a bisect while keeping the driver code itself the same will 
> > hopefully identify what that change is..
> 
> Ah, right... sata_nv.c of course interacts with the outside world, d'oh!
> 
> Up to now, I only got bad kernels, latest tested being:
> 94fcda1f8ab5e0cacc381c5ca1cc9aa6ad523576
> 
> Which, unless I missed a commit in the diff, only USB changes,
> continuing anyway.

All kernels were bad using that approach. So back to square 1. :/

Björn
