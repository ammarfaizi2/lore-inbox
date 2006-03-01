Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWCACBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWCACBz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 21:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWCACBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 21:01:55 -0500
Received: from cantor2.suse.de ([195.135.220.15]:7139 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932647AbWCACBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 21:01:55 -0500
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 05/39] [PATCH] i386: Move phys_proc_id/early intel workaround to corr
Date: Wed, 1 Mar 2006 03:03:26 +0100
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-stable <stable@kernel.org>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>
References: <200602282039_MC3-1-B985-4C46@compuserve.com>
In-Reply-To: <200602282039_MC3-1-B985-4C46@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603010303.27474.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ==> This has been in this location since at least 2.6.9.  If it's also
> needed in generic_identify(), fine, but it should be left here too.  I
> think this patch in 2.6.16-rc is wrong.  The comment for this function says
> it really needs accurate cache alignment information, presumably because
> it's needed for early boot setup, and without this it won't be accurate.

Actually it's ok because early_cpu_detect() is called from setup_arch()
which is way before kmem_cache_init() which is the first user of the 
alignment information.

So I think the patch is fine. You're right the comment could need updating
though.

Thanks for the review.

-Andi
