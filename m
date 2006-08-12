Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbWHLTIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWHLTIj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 15:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbWHLTIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 15:08:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:21008 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030270AbWHLTIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 15:08:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X/wRiFUd0fviHzjmZp5ucfQvwzbqRbBjYx/ztCxgWxhgjl8c7aw+A4kWwLnKUdbpRuujAIO6mTbwLpjrexEeNtCF4MzVQUkhtsOaNbh8N3JYiiZY0h5j9ra5v5nfvDNq7fuP/rkm2vf9tviFI09MoSKGPqXw7hVMwMGBYahpt88=
Message-ID: <4807377b0608121208g1bf4eebasc51f99fe00889bd7@mail.gmail.com>
Date: Sat, 12 Aug 2006 12:08:35 -0700
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.18-rc4 (and earlier): CMOS clock corruption during suspend to disk on i386
Cc: "Pavel Machek" <pavel@suse.cz>, "Andrew Morton" <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       "Linux ACPI" <linux-acpi@vger.kernel.org>
In-Reply-To: <200608102251.20707.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608091426.31762.rjw@sisk.pl> <20060810001232.GB4249@ucw.cz>
	 <200608101415.21505.rjw@sisk.pl> <200608102251.20707.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/06, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > > > CONFIG_PM_TRACE=y will scrog your CMOS clock each time you suspend.
> > > >
> > > > Oh dear.  Of course it's set in my .config.  Thanks a lot for this hint. :-)
> > > >
> > > > BTW, it's a dangerous setting, because some drivers get mad if the time after
> > > > the resume appears to be earlier than the time before the suspend.  Also the
> > > > timer .suspend/.resume routines aren't prepared for that.
> > >
> > > Its config option should just go away. People comfortable using *that*
> > > should just edit some header file. Rafael, could you do patch doing
> > > something like that?

I've seen this problem too, thought it was only mm.
Should the problem go away if I disable CONFIG_PM_TRACE?
