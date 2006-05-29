Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWE2Oxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWE2Oxc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 10:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWE2Oxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 10:53:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59282 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750994AbWE2Oxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 10:53:30 -0400
Date: Mon, 29 May 2006 10:52:55 -0400
From: Dave Jones <davej@redhat.com>
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Dickson <paul@permanentmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Bisects that are neither good nor bad
Message-ID: <20060529145255.GB32274@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Paul Dickson <paul@permanentmail.com>, linux-kernel@vger.kernel.org
References: <20060528140238.2c25a805.dickson@permanentmail.com> <20060528140854.34ddec2a.paul@permanentmail.com> <200605282324.13431.rjw@sisk.pl> <200605282324.13431.rjw@sisk.pl> <20060528213414.GC5741@redhat.com> <r6u079rrik.fsf@skye.ra.phy.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <r6u079rrik.fsf@skye.ra.phy.cam.ac.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2006 at 12:37:23PM +0100, Sanjoy Mahajan wrote:
 > Dave Jones <davej@redhat.com> writes:
 > 
 > > I think I've seen the same problem on one of my (similar spec) laptops.
 > > Serial console was useless. On resume, there's a short spew of garbage
 > > (just like if the baud rate were misconfigured) over serial before it
 > > locks up completely.
 > 
 > <http://bugzilla.kernel.org/show_bug.cgi?id=4270> discusses a similar
 > problem on a couple of machines.  In my resume script (for a TP 600X),
 > I have to restore the serial console with
 > 
 >   setserial -a /dev/ttyS0
 > 
 > Until that magic executes, garbage characters (like modem noise)
 > appear across the serial console.

With the resume failure I'm seeing, we don't get back to userspace
to run anything like this. It goes bang long before that.

The SATA fix Mark proposed also didn't improve the situation for me :-/

		Dave

-- 
http://www.codemonkey.org.uk
