Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263684AbUJ3ABq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263684AbUJ3ABq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 20:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263677AbUJ2X7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 19:59:17 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:43630 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S263694AbUJ2Xoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 19:44:38 -0400
Subject: Re: 2.6.9 kernel oops with openais
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: Chris Wright <chrisw@osdl.org>
Cc: Mark Haverkamp <markh@osdl.org>, Openais List <openais@lists.osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041029163944.H14339@build.pdx.osdl.net>
References: <1099090282.14581.19.camel@persist.az.mvista.com>
	 <1099091302.13961.42.camel@markh1.pdx.osdl.net>
	 <1099091816.14581.22.camel@persist.az.mvista.com>
	 <20041029163944.H14339@build.pdx.osdl.net>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Message-Id: <1099093468.1207.8.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 29 Oct 2004 16:44:29 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The use case is this (on 2.6.9):

task starts as uid 0
task calls mlockall
task allocates several mb of ram
task drops root privs to non prived uid
further memory allocations fail

Thanks
-steve

On Fri, 2004-10-29 at 16:39, Chris Wright wrote:
> * Steven Dake (sdake@mvista.com) wrote:
> > well probably all related..  The best way around the memset problem is
> > to comment out the code that does the mlockall (the function is
> > aisexec_mlockall().  This then allows all memory allocations to
> > succeed.  I think there must be some new limit with mlockall in the
> > 2.6.9 kernel series or later.
> 
> What's the mlock issue?  I changed that code about 2.6.9-rc4.
> 
> thanks,
> -chris

