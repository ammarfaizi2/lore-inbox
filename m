Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264213AbUGFRJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbUGFRJs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 13:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264228AbUGFRJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 13:09:48 -0400
Received: from fmr02.intel.com ([192.55.52.25]:2755 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S264213AbUGFRJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 13:09:45 -0400
Subject: Re: problems getting SMP to work with vanilla 2.4.26
From: Len Brown <len.brown@intel.com>
To: Zack Brown <zbrown@tumblerings.org>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20040706164839.GA1094@tumblerings.org>
References: <A6974D8E5F98D511BB910002A50A6647615FF683@hdsmsx403.hd.intel.com>
	 <1089054464.15675.56.camel@dhcppc4> <20040706164839.GA1094@tumblerings.org>
Content-Type: text/plain
Organization: 
Message-Id: <1089133780.15675.468.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 06 Jul 2004 13:09:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-06 at 12:48, Zack Brown wrote:
> Hi Len,
> 
> On Mon, Jul 05, 2004 at 03:07:44PM -0400, Len Brown wrote:
> > On Sat, 2004-07-03 at 22:05, Zack Brown wrote:
> > > Hi folks,
> > > 
> > > When booting vanilla 2.4.26 with SMP enabled, I get a lockup
> before
> > > the
> > > boot sequence is completed. The same kernel with SMP disabled
> boots
> > > and runs
> > > just fine. Both CPUs are detected by the system at bootup, before
> lilo
> > > takes
> > > over. Here's the error as I wrote it down from the screen,
> followed by
> > > the
> > > .config file:
> > e 
> > > ------------------------------ cut here
> ------------------------------
> > > Using local APIC timer interrupts.
> > > Calibrating APIC timer...
> > > ..... CPU clock speed is 1004.4785 MHZ
> > > ..... hostbus clock speed is 133.9304 MHz
> > > cpu: 0, clocks: 1339304, slice: 446434
> > > CPU0<T0:1339296,T1:892848,D:14,S:446434,C:1339304>
> > > cpu: 1, clocks: 1339304, slice: 446434
> > > CPU1<T0:1339296,T1:446416,D:12,S:446434,C:1339304>
> > > ------------------------------ cut here
> ------------------------------
> > 
> > complete dmesg from success case would help,
> > but try booting with "acpi=off", as that will
> > disable ACPI for CPU enumeration, and if there
> > is a bug in your ACPI tables, it would avoid it.
> 
> I tried acpi=off, and got a hang at boot right after the line:
> 
> CPU0<T0:1339376,T1:892912,D:4,S:446460,C:1339380

sounds like there is no SMP success case on this box with any OS?
Maybe a hardware problem.  See if you
can simplify the hardware by ripping stuff out
until it works.  Alternatively, if you find a
different OS or version of linux that boots SMP,
then that suggests a Linux specific issue.

cheers,
-Len


