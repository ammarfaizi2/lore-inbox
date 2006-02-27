Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWB0XQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWB0XQd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 18:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbWB0XQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 18:16:32 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:42115 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751345AbWB0XQc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 18:16:32 -0500
Date: Mon, 27 Feb 2006 15:18:14 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Ashok Raj <ashok.raj@intel.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [patch 10/39] [PATCH] i386/x86-64: Dont IPI to offline cpus on shutdown
Message-ID: <20060227231814.GN3883@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org> <20060227223344.160102000@sorel.sous-sol.org> <200602272337.56509.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602272337.56509.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@suse.de) wrote:
> On Monday 27 February 2006 23:32, Chris Wright wrote:
> > -stable review patch.  If anyone has any objections, please let us know.
> > ------------------
> > 
> > So why are we calling smp_send_stop from machine_halt?
> 
> I don't think that one is really suitable for stable since it's
> a relative obscure problem and the fix is not fully clear. Also it might
> have side effects. Shouldn't be merged.

This was sent in by both Andrew and Ashok, and is upstream (although Eric
notes there's more to the comprehensive solution).  It allegedly solves:

http://bugzilla.kernel.org/show_bug.cgi?id=6077

Although the reporter seems to have gone silent.  Unless there's some
compelling evidence otherwise, I'm happy to drop it.

thanks,
-chris
