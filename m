Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWE2Lhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWE2Lhr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 07:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWE2Lhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 07:37:46 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:65476 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750791AbWE2Lhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 07:37:46 -0400
To: Dave Jones <davej@redhat.com>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Dickson <paul@permanentmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Bisects that are neither good nor bad
References: <20060528140238.2c25a805.dickson@permanentmail.com>
	<20060528140854.34ddec2a.paul@permanentmail.com>
	<200605282324.13431.rjw@sisk.pl> <200605282324.13431.rjw@sisk.pl>
	<20060528213414.GC5741@redhat.com>
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Date: 29 May 2006 12:37:23 +0100
In-Reply-To: <20060528213414.GC5741@redhat.com>
Message-ID: <r6u079rrik.fsf@skye.ra.phy.cam.ac.uk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:

> I think I've seen the same problem on one of my (similar spec) laptops.
> Serial console was useless. On resume, there's a short spew of garbage
> (just like if the baud rate were misconfigured) over serial before it
> locks up completely.

<http://bugzilla.kernel.org/show_bug.cgi?id=4270> discusses a similar
problem on a couple of machines.  In my resume script (for a TP 600X),
I have to restore the serial console with

  setserial -a /dev/ttyS0

Until that magic executes, garbage characters (like modem noise)
appear across the serial console.

-Sanjoy
