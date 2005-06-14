Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVFNCBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVFNCBl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 22:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVFNCBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 22:01:41 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:4581 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261389AbVFNCBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 22:01:38 -0400
Subject: Re: [PATCH 1/4] new timeofday core subsystem (v. B2)
From: john stultz <johnstul@us.ibm.com>
To: Frank Sorenson <frank@tuxrocks.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org, kernel-stuff@comcast.net
In-Reply-To: <42AE453B.4050507@tuxrocks.com>
References: <1118286702.5754.44.camel@cog.beaverton.ibm.com>
	 <42AE453B.4050507@tuxrocks.com>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 19:01:32 -0700
Message-Id: <1118714492.27071.17.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 20:47 -0600, Frank Sorenson wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> john stultz wrote:
> > Hey Everyone,
> > 	I'm heading out on vacation until Monday, so I'm just re-spinning my
> > current tree for testing. If there's no major issues on Monday, I'll re-
> > diff against Andrew's tree and re-submit the patches for inclusion.
>
> I'm not sure what change caused this, but it seems that keyboard and
> mouse interrupts are firing more than once when I'm using the c3tsc
> timesource.  It manifests itself as multiple keypresses and odd mouse
> tapping.  The problem seems to appear only in X, and it's definitely
> confined to c3tsc (jiffies, pit, tsc-interp, and acpi_pm all seem to
> work fine [1]).

Can you confirm that this is a new issue? 

Also can you run the following:

while true
do
	ntpdate -uq  <some ntp server> 
	sleep 60
done

To make sure its not clock-drift related?

thanks
-john



