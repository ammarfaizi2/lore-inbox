Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVARWsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVARWsa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 17:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVARWs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 17:48:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:23716 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261465AbVARWrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 17:47:48 -0500
Date: Tue, 18 Jan 2005 14:47:37 -0800
From: Chris Wright <chrisw@osdl.org>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       greg@kroah.com, Emily Ratliff <emilyr@us.ibm.com>,
       Tom Lendacky <toml@us.ibm.com>, tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/1] tpm: fix cause of SMP stack traces
Message-ID: <20050118144737.B24171@build.pdx.osdl.net>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com> <Pine.LNX.4.58.0412161632200.4219@jo.austin.ibm.com> <Pine.LNX.4.58.0412171642570.9229@jo.austin.ibm.com> <Pine.LNX.4.58.0412201146060.10943@jo.austin.ibm.com> <29495f1d041221085144b08901@mail.gmail.com> <Pine.LNX.4.58.0412211209410.14092@jo.austin.ibm.com> <Pine.LNX.4.58.0501121236180.2453@jo.austin.ibm.com> <Pine.LNX.4.58.0501181621200.2473@jo.austin.ibm.com> <20050118143705.F469@build.pdx.osdl.net> <1106088256.2324.14.camel@jo.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1106088256.2324.14.camel@jo.austin.ibm.com>; from kjhall@us.ibm.com on Tue, Jan 18, 2005 at 04:44:16PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kylene Hall (kjhall@us.ibm.com) wrote:
> I actually had to move the location of some of the locks to remove the
> might sleep warnings.

Ah, that sounds like the proper fix.

> Since I didn't know much about the might sleep
> warnings before, my first course of action was to try using the disable
> irq mechanism and I went ahead and just left them in once it was working
> with the new lock placements.  I assume you believe they shouldn't be
> necessary at all?

Right.  Unless you're taking same spin_lock in irq context (which I
didn't recall you were doing).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
