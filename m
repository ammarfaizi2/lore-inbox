Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266052AbUFPBMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266052AbUFPBMd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 21:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266054AbUFPBMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 21:12:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:20131 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266052AbUFPBMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 21:12:32 -0400
Date: Tue, 15 Jun 2004 18:12:30 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Sabharwal, Atul" <atul.sabharwal@intel.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Announce] Non Invasive Kernel Monitor for threads/processes
Message-ID: <20040615181230.V21045@build.pdx.osdl.net>
References: <66539F0E7F15B44C9C0FC50D0FF024F7B1A324@orsmsx407>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <66539F0E7F15B44C9C0FC50D0FF024F7B1A324@orsmsx407>; from atul.sabharwal@intel.com on Tue, Jun 15, 2004 at 05:54:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Sabharwal, Atul (atul.sabharwal@intel.com) wrote:
> 
> How does auditing work in the event of a process failure ? There would
> be
> no system call triggered in that case.  Also, my initial thoughts are 

Correct.  Currently the main audit user is selinux, which gets
indication of the process death from LSM.

> that the non-invasive Kmonitor is lesser performance impact when
> compared
> to auditing. I would spend some time developing sample code to confirm
> it.

Yes it's possible, but the audit context is per task, and can be
filtered per task, so overhead should only effect the tasks you care
about.

> I have not looked at the task ornament patch. If you could send me a
> link.

I have nothing more recent than you'll find in google, sorry.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
