Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVASHLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVASHLv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 02:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVASHLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 02:11:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:38340 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261607AbVASHLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:11:44 -0500
Date: Tue, 18 Jan 2005 23:11:43 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] /proc/<pid>/rlimit
Message-ID: <20050118231143.K24171@build.pdx.osdl.net>
References: <20050118204457.GA7824@ti64.telemetry-investments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050118204457.GA7824@ti64.telemetry-investments.com>; from brugolsky@telemetry-investments.com on Tue, Jan 18, 2005 at 03:44:57PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bill Rugolsky Jr. (brugolsky@telemetry-investments.com) wrote:
> This patch against 2.6.11-rc1-bk6 adds /proc/<pid>/rlimit to export
> per-process resource limit settings.  It was written to help analyze
> daemon core dump size settings, but may be more generally useful.
> Tested on 2.6.10. Sample output:

I can certainly see how it could be useful for debugging.  Perhaps it
should be available to only oneself (like getrlimit restriction) or
CAP_SYS_RESOURCE processes?  (Though, I'm not sure how useful the data
would be to a malicious user).  Also, since the format is both arch
dependent and release dependent I guess it's not ideal for anything that
depends on the format.

> +const char * const rlim_name[RLIM_NLIMITS] = {
> +#ifdef RLIMIT_CPU
> +	[RLIMIT_CPU] = "cpu",
> +#endif

BTW, when I went through the resource.h files, I didn't notice any that
leftout rlimits, it was only about ordering.  So I don't think those
ifdefs are necessary.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
