Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265809AbTIJVic (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 17:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265811AbTIJVib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 17:38:31 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:62902 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265809AbTIJVi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 17:38:29 -0400
Date: Wed, 10 Sep 2003 14:38:21 -0700
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: andrew.grover@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deal with lack of acpi prt entries gracefully
Message-ID: <20030910213821.GA17356@sgi.com>
Mail-Followup-To: Andrew de Quincey <adq_dvb@lidskialf.net>,
	andrew.grover@intel.com, linux-kernel@vger.kernel.org
References: <20030909201310.GB6949@sgi.com> <200309092238.27112.adq_dvb@lidskialf.net> <20030909220142.GA7668@sgi.com> <200309102230.29794.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309102230.29794.adq_dvb@lidskialf.net>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 10:30:29PM +0100, Andrew de Quincey wrote:
> So, exactly as your patch did, you just want it to drop back if there were no 
> PCI routing entries found by ACPI... sounds sensible enough.
> 
> Can you confirm I have this right?

Yep, that's it.  The code should do that, but we get there before the
list has been initialized, so we just hang.

Thanks,
Jesse
