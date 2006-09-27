Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965553AbWI0K7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965553AbWI0K7S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 06:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965557AbWI0K7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 06:59:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:11234 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965553AbWI0K7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 06:59:17 -0400
X-Authenticated: #14349625
Subject: Re: [GIT PATCH] Driver Core patches for 2.6.18
From: Mike Galbraith <efault@gmx.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1159354112.6374.3.camel@Homer.simpson.net>
References: <20060926053728.GA8970@kroah.com>
	 <20060926203948.GB15674@suse.de>
	 <1159346843.6957.21.camel@Homer.simpson.net>
	 <200609270858.43361.rjw@sisk.pl>
	 <1159354112.6374.3.camel@Homer.simpson.net>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 13:03:26 +0000
Message-Id: <1159362206.6417.34.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-27 at 10:48 +0000, Mike Galbraith wrote:
> On Wed, 2006-09-27 at 08:58 +0200, Rafael J. Wysocki wrote:
> 
> > Please try to remove the acpi_cpufreq driver before the suspend.
> 
> Yeah, that's what's causing the suspend failure.  Thanks.

Followup:

Without the P-States driver (CONFIG_X86_ACPI_CPUFREQ) enabled, both
virgin 2.6.18 and 2.6.18 with this patchset suspend/resume just fine,
and cpufreq (p4_clockmod) works fine.

Why CONFIG_X86_ACPI_CPUFREQ blows my box out of the water with the
patchset applied, I have no idea.  Enabling suspend tracing didn't do
anything for me except cause fsck to check my drive, me to reset my
clock, only to have fsck then check my drive yet again :)

	-Mike

