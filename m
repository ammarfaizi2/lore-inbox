Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbVLMTQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbVLMTQZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 14:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbVLMTQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 14:16:24 -0500
Received: from mail.kroah.org ([69.55.234.183]:41881 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932325AbVLMTQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 14:16:15 -0500
Date: Tue, 13 Dec 2005 10:11:44 -0800
From: Greg KH <greg@kroah.com>
To: Daniel Drake <dsd@gentoo.org>
Cc: Greg KH <gregkh@suse.de>, torvalds@osdl.org,
       "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, len.brown@intel.com,
       Justin Forbes <jmforbes@linuxtx.org>, linux-kernel@vger.kernel.org,
       Randy Dunlap <rdunlap@xenotime.net>, venkatesh.pallipadi@intel.com,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       stable@kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] Re: [patch 10/26] ACPI: Prefer _CST over FADT for C-state capabilities
Message-ID: <20051213181144.GA12947@kroah.com>
References: <20051213073430.558435000@press.kroah.org> <20051213082251.GK5823@kroah.com> <439EF02F.8020300@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439EF02F.8020300@gentoo.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 04:00:47PM +0000, Daniel Drake wrote:
> Greg KH wrote:
> >-stable review patch.  If anyone has any objections, please let us know.
> >
> >------------------
> >From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> >
> >Note: This ACPI standard compliance may cause regression
> >on some system, if they have _CST present, but _CST value
> >is bogus. "nocst" module parameter should workaround
> >that regression.
> >
> >http://bugzilla.kernel.org/show_bug.cgi?id=5165
> >
> >(cherry picked from 883baf7f7e81cca26f4683ae0d25ba48f094cc08 commit)
> >
> >Signed-off-by: Venkatesh Pallipadi<venkatesh.pallipadi@intel.com>
> >Signed-off-by: Len Brown <len.brown@intel.com>
> >Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> >---
> > drivers/acpi/processor_idle.c |   10 +++++-----
> > 1 file changed, 5 insertions(+), 5 deletions(-)
> 
> Venkatesh followed up in a private email that a 3rd patch is needed to  
> solve the hyperthreading slowdown issue. This patch is not yet in Linus' 
> tree (it is in acpi-test).
> 
> Maybe we should drop these patches (10 and 12) until the 3rd patch has been 
> merged. I haven't been shipping the 3rd patch in Gentoo (yet) so I'm not 
> able to gauge its effect...

Ok, as these two patches don't solve anything, I'll just drop them from
the series.  If the third one makes it into mainline, let us know and we
can add all 3 to the -stable tree.

thanks,

greg k-h
