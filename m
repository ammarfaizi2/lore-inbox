Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWBQSUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWBQSUw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 13:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWBQSUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 13:20:51 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:45741 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751167AbWBQSUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 13:20:51 -0500
Date: Fri, 17 Feb 2006 10:21:04 -0800
From: Don Fry <brazilnut@us.ibm.com>
To: Seewer Philippe <philippe.seewer@bfh.ch>
Cc: tsbogend@alpha.franken.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] pcnet32: Introduce basic AT 2700/01 FTX support
Message-ID: <20060217182104.GA19257@us.ibm.com>
References: <43F5F66F.6040608@bfh.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F5F66F.6040608@bfh.ch>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe,

On a purely mechanical note, the patches do not apply cleanly because
of whitespace changes.  Possibly your mailer changed tabs to spaces,
which causes the patch not to apply, and also causes your patch to have
different spacing than the rest of the file.  The driver does not
conform to the 8-space indentation guideline/rule, but it is consistent
in 4-space indentation.

I am looking over this change and the following one, to try and
understand what and why you made your changes.

The change made by Thomas Bogendoerfer and modified by myself is much
more flexible than your changes, in that they are not specific just to
the Allied Telesyn boards with multiple Phys.  They also allow dynamic
changing of cabling without requiring the driver to be removed/installed
or the card power cycled.  I also see little value in the module
parameters, when it can be determined dynamically. Also, maxphy might be
thought to the the maximum number of phys, rather than the maximum phy
number supported.  If static selection of the phy to use is passed in as
a module parameter, why also include a maxphy?

As I review your patches I will follow up to the mailing list.

On Fri, Feb 17, 2006 at 05:14:39PM +0100, Seewer Philippe wrote:
> 
> This patch extends Don Fry's last patch for AT 2700/01 FX to set the
> speed/fdx options for the FTX variants of these cards as well.
> 
> Additionally the option override has been moved from pcnet32_open to
> pcnet32_probe1 because it's only necessary to override the options once.
> 
> Tested and works.
> 
> Patch applies to 2.6.16-rc3
> 
Don Fry
brazilnut@us.ibm.com
