Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbTIKMpn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 08:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbTIKMpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 08:45:43 -0400
Received: from luli.rootdir.de ([213.133.108.222]:64696 "HELO luli.rootdir.de")
	by vger.kernel.org with SMTP id S261270AbTIKMpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 08:45:41 -0400
Date: Thu, 11 Sep 2003 14:45:30 +0200
From: Claas Langbehn <claas@rootdir.de>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew de Quincey <adq@lidskialf.net>,
       acpi-devel@lists.sourceforge.net
Subject: Re: [2.6.0-test5-mm1] Suspend to RAM problems
Message-ID: <20030911124530.GA7695@rootdir.de>
References: <20030910103142.GA1053@rootdir.de> <Pine.LNX.4.33.0309100829470.1012-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0309100829470.1012-100000@localhost.localdomain>
Reply-By: So Sep 14 14:31:28 CEST 2003
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.0-test5-mm1 i686
X-No-archive: yes
X-Uptime: 14:31:28 up  2:14,  5 users,  load average: 0.06, 0.27, 0.27
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:

> > 2) ACPI
> > Thanks to Andrew de Quincey I can boot with ACPI without
> > problems and I can read out my temp and so on, but when I do
> >    echo -n "mem" >/sys/power/state 
> > the machine goes into sleep (STR) but crashes after waking up again.
> 
> What exactly does it do on wakeup? 
> 
> Would you please try the patch at: 
> 
> http://developer.osdl.org/~mochel/patches/test5-pm1/test5-pm2.diff.bz2
> 
> against 2.6.0-test5 and report whether or not it works? 

[...]
  CC      drivers/acpi/sleep/proc.o
  drivers/acpi/sleep/proc.c: In function `acpi_system_write_sleep':
  drivers/acpi/sleep/proc.c:72: error: void value not ignored as it
  ought to be
  make[3]: *** [drivers/acpi/sleep/proc.o] Error 1
  make[2]: *** [drivers/acpi/sleep] Error 2
  make[1]: *** [drivers/acpi] Error 2
  make: *** [drivers] Error 2


Is there an incremental patch from -pm1 to -pm2?
I would apply it to -test5-mm1 then



claas
