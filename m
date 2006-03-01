Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751933AbWCAWvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbWCAWvV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 17:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbWCAWvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 17:51:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60606 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751933AbWCAWvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 17:51:20 -0500
Date: Wed, 1 Mar 2006 17:51:03 -0500
From: Dave Jones <davej@redhat.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Michael Ellerman <michael@ellerman.id.au>, linux-kernel@vger.kernel.org,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [PATCH] leave APIC code inactive by default on i386
Message-ID: <20060301225103.GE1440@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Darrick J. Wong" <djwong@us.ibm.com>,
	Michael Ellerman <michael@ellerman.id.au>,
	linux-kernel@vger.kernel.org, Chris McDermott <lcm@us.ibm.com>
References: <43D03AF0.3040703@us.ibm.com> <dc1166600602281957h4158c07od19d0e5200d21659@mail.gmail.com> <20060301043353.GJ28434@redhat.com> <1141248546.30185.44.camel@localhost.localdomain> <20060301221404.GA1440@redhat.com> <1141253258.30185.60.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141253258.30185.60.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 02:47:38PM -0800, Darrick J. Wong wrote:
 > On Wed, 2006-03-01 at 17:14 -0500, Dave Jones wrote:
 > 
 > > In light of Matthew's comments in this thread though, I'm also wondering
 > > if we can now get by without this diff, and just enable it by default now
 > > that the kernel respects that the BIOS and leaves it alone if it's been
 > > disabled.
 > 
 > Actually, it seems that there are Lenovo ThinkCenter P4 machines with
 > buggy BIOSes that tell us that we can enable the APIC ... but doing so
 > eventually causes the system to hang.  Granted, the Google-recommended
 > fixes are "noapic" or "Update the BIOS", but perhaps it would be best to
 > leave it off _except_ for the few cases where we know that we need it.
 > 
 > (Then again, the correct solution in this case is to fix the BIOS...)

Indeed. And also blacklist the bad ones with DMI entries.

		Dave
