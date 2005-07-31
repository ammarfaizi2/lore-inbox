Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVGaC4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVGaC4p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 22:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVGaC4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 22:56:45 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:1502 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261540AbVGaC4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 22:56:44 -0400
Subject: SOLVED - Re: Simple question re: oops
From: Lee Revell <rlrevell@joe-job.com>
To: Dave Airlie <airlied@gmail.com>
Cc: Alexander Nyberg <alexn@telia.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e997050730174034a68f4@mail.gmail.com>
References: <1122767292.4464.1.camel@mindpipe>
	 <20050731001101.GA6762@localhost.localdomain>
	 <1122769290.4464.12.camel@mindpipe>
	 <21d7e997050730174034a68f4@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 30 Jul 2005 22:50:46 -0400
Message-Id: <1122778246.5473.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-31 at 10:40 +1000, Dave Airlie wrote:
> > panic_on_oops has no effect, a bunch of stuff flies past and the last
> > thing I see is "gam_server: scheduling while atomic" then a stack trace
> > of the core dump path then "Aiee, killing interrupt handler".
> > 
> > I am starting to suspect the hard drive, does that sound plausible?
> > It's as if it locks up when it hits a certain disk block.
> 
> run memtest on it... you might have bad RAM..

This was some kind of (ACPI related?) kernel bug.  I upgraded from Hoary
(2.6.11) to Breezy (2.6.12) and the problem which had been 100%
reproducible went away.

One strange thing I noticed was some strange APM/ACPI related messages
in the logs when starting X (APM: overridden by ACPI or something).  Now
I don't get these and the X log just says /dev/apm_bios: No such device.

Oh well, it's working now.

Lee

