Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVDDJf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVDDJf5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 05:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVDDJf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 05:35:57 -0400
Received: from fmr17.intel.com ([134.134.136.16]:32479 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261192AbVDDJfm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 05:35:42 -0400
From: "Yu, Luming" <luming.yu@intel.com>
Reply-To: luming.yu@intel.com
To: acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] 2.6.12-rc1-mm[1-3]: ACPI battery monitor does not work
Date: Mon, 4 Apr 2005 17:34:23 +0800
User-Agent: KMail/1.6.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "LKML" <linux-kernel@vger.kernel.org>
References: <200503291156.19112.rjw@sisk.pl> <200504011731.16467.luming.yu@intel.com> <200504011151.48468.rjw@sisk.pl>
In-Reply-To: <200504011151.48468.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200504041734.23178.luming.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please testing patch filed at
http://bugzilla.kernel.org/show_bug.cgi?id=3851#c64
My testing results on toshiba satellite M20 is:

/proc/acpi/battery/BAT0#time cat state
present:                 yes
capacity state:          ok
charging state:          charging
present rate:            1500 mA
remaining capacity:      4064 mAh
present voltage:         15000 mV

real    0m0.023s
user    0m0.000s
sys     0m0.020s

Thanks
Luming

On Friday 01 April 2005 17:51, Rafael J. Wysocki wrote:
> On Friday, 1 of April 2005 11:31, Yu, Luming wrote:
>  > On Thursday 31 March 2005 16:44, Rafael J. Wysocki wrote:
>  > > Hi,
>  > >
>  > > On Wednesday, 30 of March 2005 12:05, Rafael J. Wysocki wrote:
>  > > > On Wednesday, 30 of March 2005 07:53, Yu, Luming wrote:
>  > > > > On Tuesday 29 March 2005 17:56, Rafael J. Wysocki wrote:
>  > > > > > Hi,
>  > > > > >
>  > > > > > There is a problem on my box (Asus L5D, x86-64 kernel) with the
>  > > > > > ACPI battery driver in the 2.6.12-rc1-mm[1-3] kernels.  Namely,
>  > > > > > the battery monitor that I use (the kpowersave applet from SUSE
>  > > > > > 9.2) is no longer able to report the battery status (ie how much
>  > > > > > % it is loaded).  It can only check if the AC power is connected
>  > > > > > (if it is connected, kpowersave behaves as though there was no
>  > > > > > battery in the box, and if it is not connected, kpowersave
>  > > > > > always shows that the battery is 1% loaded).
>  > > > > >
>  > > > > > Also, there are big latencies on loading and accessing the
>  > > > > > battery module, but the module loads successfully and there's
>  > > > > > nothing suspicious in dmesg.
>  > > > > >
>  > > > > > Please let me know if you need any additional information.
>  > > > > >
>  > > > > > Greets,
>  > > > > > Rafael
>  > > > >
>  > > > > Could you just revert ec-mode patch, then retest?
>  > > >
>  > > > Could you please point me to it?
>  > >
>  > > I assume you mean the "Enable EC Burst Mode" patch at:
>  > >
>  > > http://linux-acpi.bkbits.net:8080/to-akpm/cset%401.2181.17.12?nav=inde
>  > >x.htm l|ChangeSet@-2w
>  > >
>  > > Anyway, reverting this patch helps. :-)
>  >
>  > Could you let me see Dmesg and  DSDT?
>
>  They are available at:
>
>  http://www.sisk.pl/kernel/050401/dmesg.out
>  http://www.sisk.pl/kernel/050401/dsdt
>
>  The dmesg output is from 2.6.12-rc1-mm4 with the patch reverted.
>
>  Greets,
>  Rafael
>
>
>  --
>  - Would you tell me, please, which way I ought to go from here?
>  - That depends a good deal on where you want to get to.
>                  -- Lewis Carroll "Alice's Adventures in Wonderland"
>
>
>  -------------------------------------------------------
>  This SF.net email is sponsored by Demarc:
>  A global provider of Threat Management Solutions.
>  Download our HomeAdmin security software for free today!
>  http://www.demarc.com/Info/Sentarus/hamr30
>  _______________________________________________
>  Acpi-devel mailing list
>  Acpi-devel@lists.sourceforge.net
>  https://lists.sourceforge.net/lists/listinfo/acpi-devel
