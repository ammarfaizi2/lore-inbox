Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283981AbRLAFvT>; Sat, 1 Dec 2001 00:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281144AbRLAFvH>; Sat, 1 Dec 2001 00:51:07 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:57596
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281087AbRLAFvD>; Sat, 1 Dec 2001 00:51:03 -0500
Date: Fri, 30 Nov 2001 21:50:57 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@zip.com.au>, Larry McVoy <lm@bitmover.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Message-ID: <20011130215057.C489@mikef-linux.matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Larry McVoy <lm@bitmover.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Henning Schmiedehausen <hps@intermeta.de>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com> <E169scn-0000kt-00@starship.berlin> <20011130110546.V14710@work.bitmover.com> <E169vcF-0000lQ-00@starship.berlin>, <E169vcF-0000lQ-00@starship.berlin>; <20011130140613.F14710@work.bitmover.com> <3C08057D.48645B56@zip.com.au> <20011130155740.I14710@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011130155740.I14710@work.bitmover.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 03:57:40PM -0800, Larry McVoy wrote:
> Here's how you get both.  Fork the development efforts into the SMP part
> and the uniprocessor part.  

Basically with linux, and enough #ifdef's you end up with both in one.  IIUC

What would be nice is UP only drivers for initial release. Write a driver
module that says "I'm made for UP and haven't been tested with SMP/HighMEM"
so if you try to compile it with those features it would break with a
helpful error message.

What would be interesting would be SMP with support for UP.  The UP only
module would be inserted into a SMP kernel, but would only work inside one
processor, and would have source compatibility with both UP ans SMP kernels.
No non-UP locking required.

Is something like this possible?
