Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVCaIot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVCaIot (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 03:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVCaIot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 03:44:49 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:11240 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261193AbVCaIop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 03:44:45 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: luming.yu@intel.com
Subject: Re: [ACPI] 2.6.12-rc1-mm[1-3]: ACPI battery monitor does not work
Date: Thu, 31 Mar 2005 10:44:58 +0200
User-Agent: KMail/1.7.1
Cc: acpi-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
References: <200503291156.19112.rjw@sisk.pl> <200503301353.25492.luming.yu@intel.com> <200503301205.40555.rjw@sisk.pl>
In-Reply-To: <200503301205.40555.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503311044.58673.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 30 of March 2005 12:05, Rafael J. Wysocki wrote:
> On Wednesday, 30 of March 2005 07:53, Yu, Luming wrote:
> > On Tuesday 29 March 2005 17:56, Rafael J. Wysocki wrote:
> > > Hi,
> > >
> > > There is a problem on my box (Asus L5D, x86-64 kernel) with the ACPI
> > > battery driver in the 2.6.12-rc1-mm[1-3] kernels.  Namely, the battery
> > > monitor that I use (the kpowersave applet from SUSE 9.2) is no longer able
> > > to report the battery status (ie how much % it is loaded).  It can only
> > > check if the AC power is connected (if it is connected, kpowersave behaves
> > > as though there was no battery in the box, and if it is not connected,
> > > kpowersave always shows that the battery is 1% loaded).
> > >
> > > Also, there are big latencies on loading and accessing the battery module,
> > > but the module loads successfully and there's nothing suspicious in dmesg.
> > >
> > > Please let me know if you need any additional information.
> > >
> > > Greets,
> > > Rafael
> > 
> > Could you just revert ec-mode patch, then retest?
> 
> Could you please point me to it?

I assume you mean the "Enable EC Burst Mode" patch at:

http://linux-acpi.bkbits.net:8080/to-akpm/cset%401.2181.17.12?nav=index.html|ChangeSet@-2w

Anyway, reverting this patch helps. :-)

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
