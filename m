Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263588AbUEGOXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263588AbUEGOXO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 10:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263589AbUEGOXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 10:23:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22746 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263588AbUEGOXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 10:23:12 -0400
Date: Fri, 7 May 2004 16:23:11 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: Re: [PATCH] mxcsr patch for i386 & x86-64
Message-ID: <20040507142311.GH9255@atrey.karlin.mff.cuni.cz>
References: <E305A4AFB7947540BC487567B5449BA802CA870E@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E305A4AFB7947540BC487567B5449BA802CA870E@scsmsx402.sc.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    I have updated the mxcsr patch to also enable it at the time of
> resume. Please find the patch attached.
>   fpu_init() is needed in the resume path, only if the user want to
> change the cpu between suspend and resume. Otherwise the
> mxcsr_features_mask calculated earlier will still be valid.
> 	Also for changing the cpu, the user will need to shutdown the
> system, so it is useful for S4 (suspend to disk) state. 
>   I am testing the patch. Meanwhile please let me know if these changes
> are ok for you?

Noone should exchange CPUs while we are in S4 suspend; but handling it
can not hurt. 

Patch looks okay, thanks.
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
