Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVFFJY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVFFJY1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 05:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVFFJY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 05:24:26 -0400
Received: from isilmar.linta.de ([213.239.214.66]:6087 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261248AbVFFJYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 05:24:16 -0400
Date: Mon, 6 Jun 2005 11:24:14 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Andi Kleen <ak@suse.de>
Cc: john stultz <johnstul@us.ibm.com>,
       Parag Warudkar <kernel-stuff@comcast.net>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
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
Message-ID: <20050606092414.GA28526@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Andi Kleen <ak@suse.de>, john stultz <johnstul@us.ibm.com>,
	Parag Warudkar <kernel-stuff@comcast.net>,
	Nishanth Aravamudan <nacc@us.ibm.com>,
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
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net> <200506021905.08274.kernel-stuff@comcast.net> <1117754453.17804.51.camel@cog.beaverton.ibm.com> <200506021950.35014.kernel-stuff@comcast.net> <1117812275.3674.2.camel@leatherman> <20050605170511.GC12338@dominikbrodowski.de> <20050606092159.GZ23831@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050606092159.GZ23831@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 11:21:59AM +0200, Andi Kleen wrote:
> > IIRC (from the comment above) several chipsets suffer from this
> > inconsistency, namely the widely used PIIX4(E) and ICH(4 only? or also other
> > ICH-ones?). Therefore, we'd need at least some sort of boot-time check to
> > decide which method to use... and based on the method, we can adjust the
> > priority maybe?
> 
> At least on x86-64 there are no ICH4s or PIIX4Es. Actually I think
> there was one early prototype machine from Intel with ICH4, but I am willing
> to ignore these.  So please dont do any such things on the x86-64 version.
> 
> Also didnt ICH4 already have HPET? it might not be enabled on many
> boxes, but given the chip datasheet one can write enable code to 
> fix that.

At least on my notebook, which has an ICH4-M, there is no HPET. AFAIK it
resides on a separate chip which may or may not exist. I'd be glad if the
opposite were true, though :)

	Dominik
