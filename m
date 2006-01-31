Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWAaQfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWAaQfB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 11:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWAaQfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 11:35:01 -0500
Received: from 66.239.25.20.ptr.us.xo.net ([66.239.25.20]:17637 "EHLO
	zoot.lnxi.com") by vger.kernel.org with ESMTP id S1751180AbWAaQfA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 11:35:00 -0500
Subject: Re: noisy edac
From: doug thompson <dthompson@linuxnetworx.com>
To: Dave Peterson <dsp@llnl.gov>
Cc: "Eric W. Biederman" <ebiederman@lnxi.com>,
       Gunther Mayer <gunther.mayer@gmx.net>,
       "bluesmoke-devel@lists.sourceforge.net" 
	<bluesmoke-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200601302015.13057.dsp@llnl.gov>
References: <20060130185931.71975.qmail@web50112.mail.yahoo.com>
	 <200601301653.15984.dsp@llnl.gov> <m3zmldjd31.fsf@maxwell.lnxi.com>
	 <200601302015.13057.dsp@llnl.gov>
Content-Type: text/plain
Date: Tue, 31 Jan 2006 09:34:35 -0700
Message-Id: <1138725275.8251.96.camel@logos.linuxnetworx.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-30 at 20:15 -0800, Dave Peterson wrote:
> On Monday 30 January 2006 19:22, Eric W. Biederman wrote:
> > One piece missing from this conversation is the issue that we need errors
> > in a uniform format.  That is why edac_mc has helper functions.
> >
> > However there will always be errors that don't fit any particular model.
> > Could we add a edac_printk(dev, );  That is similar to dev_printk but
> > prints out an EDAC header and the device on which the error was found?
> > Letting the rest of the string be user specified.
> 
> I like this idea.  It would facilitate grepping in logfiles for
> EDAC-related errors.

Yes, eric, that puts into words what I was trying to express.

Refactor all the MC drivers to utilize such a 'edac_printk()' helper
function, and add control mechanisms to that function for level of
output, etc. Then the begining format of the output stream can be
"tagged" as EDAC output, etc, for harvest patterns.

As to Dave Jones original, I remember that the "NON-FATAL" tag was still
indicating that some error was occuring, but it wasn't a "take the
machine down" type of event. But it was some problem.  Time to break out
the Intel Specs for that MC.

doug t


