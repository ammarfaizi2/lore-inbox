Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbVKRVTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbVKRVTN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 16:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbVKRVTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 16:19:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50589 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750935AbVKRVTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 16:19:13 -0500
Date: Fri, 18 Nov 2005 16:18:47 -0500
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051118211847.GA3881@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>
References: <20051115212942.GA9828@elf.ucw.cz> <20051115222549.GF17023@redhat.com> <1132342590.25914.86.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132342590.25914.86.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 07:36:29PM +0000, Alan Cox wrote:
 > On Maw, 2005-11-15 at 17:25 -0500, Dave Jones wrote:
 > > Just for info: If this goes in, Red Hat/Fedora kernels will fork
 > > swsusp development, as this method just will not work there.
 > > (We have a restricted /dev/mem that prevents writes to arbitary
 > >  memory regions, as part of a patchset to prevent rootkits)
 > 
 > Perhaps it is trying to tell you that you should be using SELinux rules
 > not kernel hacks for this purpose ?

I don't think selinux can give you the granularity to say
"process can access this bit of the file only", at least not yet.

Even if that was capable however, it still doesn't solve the problem.
Pavel's implementation wants to write to arbitary address spaces, which is
what we're trying to prevent. The two are at odds with each other.

		Dave

