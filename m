Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290755AbSBOUSM>; Fri, 15 Feb 2002 15:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290768AbSBOUSC>; Fri, 15 Feb 2002 15:18:02 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:23287
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S290755AbSBOUR4>; Fri, 15 Feb 2002 15:17:56 -0500
Date: Fri, 15 Feb 2002 12:18:10 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Robert Love <rml@tech9.net>
Cc: Robert Jameson <rj@open-net.org>, linux-kernel@vger.kernel.org
Subject: Hard lockup with 2.4.18-pre9 + preempt + lock break + O1k[23] + rmap
Message-ID: <20020215201810.GA5310@matchmail.com>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	Robert Jameson <rj@open-net.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020215035135.0c26b130.rj@open-net.org> <1013780277.950.663.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1013780277.950.663.camel@phantasy>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 08:37:52AM -0500, Robert Love wrote:
> On Fri, 2002-02-15 at 03:51, Robert Jameson wrote:
> > I have been seeing this oops from 2.4.16 -> 2.4.18-pre9, so here we go!
> 
> Do you see this on device close?  It looks like there may be a race
> between device closer -> usb release.
> 

I don't use USB, and I have had several machines lock up hard while doing
medium to heavy IO.  I've had this happen with pre9-mjc2 and another patch
that just contained pre9-preempt-schedo1
(nyu.dyn.dhs.org:8080/patches/2.4.18-pre9-to-rmap12e-schedO1-rml.patch.bz2)

I'm running 2.4.18-pre9-ac3 now to see if I can reproduce without prempt and
O(1).

I have someone else from IRC that has the same issue with prempt+O(1)
against vanilla 2.4.17.  He should be sending you a bug report soon.

BTW, all machines ran the same kernel compiled for SMP, but some machines
were UP.

Has anyone else seen this?

Mike
