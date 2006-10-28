Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751696AbWJ1D6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbWJ1D6b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 23:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbWJ1D6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 23:58:31 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:3996 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1751695AbWJ1D6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 23:58:30 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.4
Subject: Re: AMD X2 unsynced TSC fix?
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Chris Friesen <cfriesen@nortel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
In-Reply-To: <1161986902.27225.206.camel@mindpipe>
References: <1161969308.27225.120.camel@mindpipe>
	 <200610271335.10178.ak@suse.de> <1161981682.27225.184.camel@mindpipe>
	 <45427E91.2000402@nortel.com>  <1161986902.27225.206.camel@mindpipe>
Content-Type: text/plain; charset=utf-8
Date: Sat, 28 Oct 2006 04:58:27 +0100
Message-Id: <1162007907.26022.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-27 at 18:08 -0400, Lee Revell wrote: 
> On Fri, 2006-10-27 at 15:48 -0600, Chris Friesen wrote:
> > Lee Revell wrote:
> > 
> > > What exactly does that AMD patch do?
> > 
> > "...by periodically adjusting the core time-stamp-counters, so that they 
> > are synchronized."
> > 
> > It sounds like they just periodically write a new value to the TSC. 
> > Presumably they set the "slower" one equal to the "faster" one.
> > 
> > You'd likely still have windows where time might run backwards, but it 
> > would be better than nothing.
> 
> The patch also apparently changes boot params to make the OS use the
> ACPI PM timer, so it must not be a complete solution.

Hi,
So far, has I can understand. Seems to me that my computer which have a
Pentium D (Dual Core) on VIA chipset, also have unsynchronized TSC and
with the patch of hrtimers on
( http://www.tglx.de/projects/hrtimers/2.6.18/ ) 
Kernel found and use a new clocksource, the acpi_pm. And works stable
but I don't deny that could be a little slower.

Just to point out. This could be more a problem of chipsets than CPUs
(AMD or Intel). AMD just begin first using x86_64 archs :)

Last Note: 
I still have other minor problem, seems (to me) related with SATA
drives. Kernel 2.4.19-rc3 have big changes on SATA and I like to test it
but can't apply hrtimers patch (I don't understand half seems in kernel
other half not). 
In rc3 with jiffies clocksource even with boot parameter "notsc" I have
unsynchronized issues and many "Lost timer tickets", but I can say that
is a regression because computer never work well.

Thanks,
--
Sérgio M. B. 

