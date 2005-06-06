Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVFFJWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVFFJWP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 05:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVFFJWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 05:22:15 -0400
Received: from mail.suse.de ([195.135.220.2]:53640 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261208AbVFFJWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 05:22:12 -0400
Date: Mon, 6 Jun 2005 11:21:59 +0200
From: Andi Kleen <ak@suse.de>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       john stultz <johnstul@us.ibm.com>,
       Parag Warudkar <kernel-stuff@comcast.net>,
       Nishanth Aravamudan <nacc@us.ibm.com>, Andi Kleen <ak@suse.de>,
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
Message-ID: <20050606092159.GZ23831@wotan.suse.de>
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net> <200506021905.08274.kernel-stuff@comcast.net> <1117754453.17804.51.camel@cog.beaverton.ibm.com> <200506021950.35014.kernel-stuff@comcast.net> <1117812275.3674.2.camel@leatherman> <20050605170511.GC12338@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050605170511.GC12338@dominikbrodowski.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IIRC (from the comment above) several chipsets suffer from this
> inconsistency, namely the widely used PIIX4(E) and ICH(4 only? or also other
> ICH-ones?). Therefore, we'd need at least some sort of boot-time check to
> decide which method to use... and based on the method, we can adjust the
> priority maybe?

At least on x86-64 there are no ICH4s or PIIX4Es. Actually I think
there was one early prototype machine from Intel with ICH4, but I am willing
to ignore these.  So please dont do any such things on the x86-64 version.

Also didnt ICH4 already have HPET? it might not be enabled on many
boxes, but given the chip datasheet one can write enable code to 
fix that.

-Andi
