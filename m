Return-Path: <linux-kernel-owner+w=401wt.eu-S1161093AbWLUBBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161093AbWLUBBv (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 20:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161100AbWLUBBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 20:01:51 -0500
Received: from ozlabs.org ([203.10.76.45]:43568 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161093AbWLUBBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 20:01:51 -0500
X-Greylist: delayed 1419 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 20:01:50 EST
Date: Thu, 21 Dec 2006 11:36:59 +1100
From: Anton Blanchard <anton@samba.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: Mutex debug lock failure [was Re: Bad gcc-4.1.0 leads to Power4 crashes... and power5 too, actually
Message-ID: <20061221003658.GB3048@krispykreme>
References: <20061220004653.GL5506@austin.ibm.com> <1166579210.4963.15.camel@otta> <20061220211931.GB16860@austin.ibm.com> <1166650134.6673.9.camel@localhost.localdomain> <20061220230342.GC16860@austin.ibm.com> <1166656195.6673.23.camel@localhost.localdomain> <20061220234647.GD16860@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220234647.GD16860@austin.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Dec 20, 2006 at 05:46:47PM -0600, Linas Vepstas wrote:

> System assert at:  file: rtas_io_config.c  -- line: 195
> rio_hub_num: 10
> drawer_num: 6
> phb_num: 3
> buid: 7

Looks like a firmware assert. Did you pass in something dodgy to a
config read/write op? Maybe a bad buid?

Anton
