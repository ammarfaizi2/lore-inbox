Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030314AbWADW0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbWADW0m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbWADW0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:26:20 -0500
Received: from isilmar.linta.de ([213.239.214.66]:17297 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1030310AbWADW0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:26:19 -0500
Date: Wed, 4 Jan 2006 23:26:18 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Ben Collins <bcollins@ubuntu.com>, davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] powernow-k7: Work when kernel is compiled for SMP
Message-ID: <20060104222618.GA24376@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Ben Collins <bcollins@ubuntu.com>, davej@redhat.com,
	linux-kernel@vger.kernel.org
References: <0ISL00NU693O1L@a34-mta01.direcway.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ISL00NU693O1L@a34-mta01.direcway.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 04:59:31PM -0500, Ben Collins wrote:
> On a UP system with SMP compiled kernel, the powernow-k7 module would not
> initialize (returned -ENODEV). Not sure why policy->cpu != 0 for UP
>
> Signed-off-by: Ben Collins <bcollins@ubuntu.com>

May the smp_processor_id() be != 0 on _true_ UP on SMP? What happens if (using
virtual CPU hotplug) the module is modprobe'd with one CPU online, and then
the second CPU becomes online later?

	Dominik
