Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVFFDOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVFFDOe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 23:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVFFDOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 23:14:34 -0400
Received: from isilmar.linta.de ([213.239.214.66]:64392 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261171AbVFFDO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 23:14:29 -0400
Date: Mon, 6 Jun 2005 05:14:28 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: john stultz <johnstul@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       David Mosberger <davidm@hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
Message-ID: <20050606031427.GA14196@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Parag Warudkar <kernel-stuff@comcast.net>,
	john stultz <johnstul@us.ibm.com>,
	Nishanth Aravamudan <nacc@us.ibm.com>, Andi Kleen <ak@suse.de>,
	lkml <linux-kernel@vger.kernel.org>,
	Tim Schmielau <tim@physik3.uni-rostock.de>,
	George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
	Christoph Lameter <clameter@sgi.com>,
	David Mosberger <davidm@hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
	paulus@samba.org, schwidefsky@de.ibm.com,
	keith maanthey <kmannth@us.ibm.com>,
	Chris McDermott <lcm@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
	mahuja@us.ibm.com, Darren Hart <darren@dvhart.com>,
	"Darrick J. Wong" <djwong@us.ibm.com>,
	Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
	benh@kernel.crashing.org
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net> <1117812275.3674.2.camel@leatherman> <20050605170511.GC12338@dominikbrodowski.de> <200506052304.35298.kernel-stuff@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506052304.35298.kernel-stuff@comcast.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jun 05, 2005 at 11:04:34PM -0400, Parag Warudkar wrote:
> tests the chipset read in the same do{}while loop - if the loop executes only 
> once, it considers the chipset good - in which case it executes the faster 
> read_pmtmr_fast function.) Or does it need wider testing under different 
> circumstances to conclude that chipset is good?

I fear that we need to run the loop a couple of times at least -- IIRC many
accesses were correct, but some failed. Will investigate soon.

> I tested the patch under Virtual PC which emulates a PIIX4 chipset. Test 
> passes there, meaning the do {}while  loop executes only once.

Possibly this is a bug-free emulation?

	Dominik
