Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751878AbWAEWc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbWAEWc5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbWAEWc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:32:57 -0500
Received: from isilmar.linta.de ([213.239.214.66]:48542 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1751878AbWAEWc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:32:56 -0500
Date: Thu, 5 Jan 2006 23:32:54 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] powernow-k7: Work when kernel is compiled for SMP
Message-ID: <20060105223254.GA11346@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Ben Collins <ben.collins@ubuntu.com>, davej@redhat.com,
	linux-kernel@vger.kernel.org
References: <0ISL00NU693O1L@a34-mta01.direcway.com> <20060104222618.GA24376@isilmar.linta.de> <1136413927.4430.35.camel@grayson>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136413927.4430.35.camel@grayson>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 05:32:06PM -0500, Ben Collins wrote:
> On Wed, 2006-01-04 at 23:26 +0100, Dominik Brodowski wrote:
> > On Wed, Jan 04, 2006 at 04:59:31PM -0500, Ben Collins wrote:
> > > On a UP system with SMP compiled kernel, the powernow-k7 module would not
> > > initialize (returned -ENODEV). Not sure why policy->cpu != 0 for UP
> > >
> > > Signed-off-by: Ben Collins <bcollins@ubuntu.com>
> > 
> > May the smp_processor_id() be != 0 on _true_ UP on SMP? What happens if (using
> > virtual CPU hotplug) the module is modprobe'd with one CPU online, and then
> > the second CPU becomes online later?
> 
> That's why there is num_possible_cpus() checked aswell. That's supposed
> to report possible hotplug cpu's, even if not plugged, correct?

Yes, sure. Sorry...

	Dominik
