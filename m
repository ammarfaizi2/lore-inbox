Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965295AbWADWcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965295AbWADWcd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965296AbWADWcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:32:33 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:8020 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S965295AbWADWcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:32:32 -0500
Date: Wed, 04 Jan 2006 17:32:06 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 03/15] powernow-k7: Work when kernel is compiled for SMP
In-reply-to: <20060104222618.GA24376@isilmar.linta.de>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Ben Collins <bcollins@ubuntu.com>, davej@redhat.com,
       linux-kernel@vger.kernel.org
Message-id: <1136413927.4430.35.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <0ISL00NU693O1L@a34-mta01.direcway.com>
 <20060104222618.GA24376@isilmar.linta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 23:26 +0100, Dominik Brodowski wrote:
> On Wed, Jan 04, 2006 at 04:59:31PM -0500, Ben Collins wrote:
> > On a UP system with SMP compiled kernel, the powernow-k7 module would not
> > initialize (returned -ENODEV). Not sure why policy->cpu != 0 for UP
> >
> > Signed-off-by: Ben Collins <bcollins@ubuntu.com>
> 
> May the smp_processor_id() be != 0 on _true_ UP on SMP? What happens if (using
> virtual CPU hotplug) the module is modprobe'd with one CPU online, and then
> the second CPU becomes online later?

That's why there is num_possible_cpus() checked aswell. That's supposed
to report possible hotplug cpu's, even if not plugged, correct?

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

