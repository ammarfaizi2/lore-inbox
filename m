Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUDJDMy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 23:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUDJDMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 23:12:53 -0400
Received: from mailhub.hp.com ([192.151.27.10]:3241 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S261879AbUDJDMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 23:12:53 -0400
Subject: Re: [ACPI] Re: [PATCH] filling in ACPI method access via sysfs
	namespace
From: Alex Williamson <alex.williamson@hp.com>
To: John Belmonte <john@neggie.net>
Cc: acpi-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4077535D.6020403@neggie.net>
References: <1081453741.3398.77.camel@patsy.fc.hp.com>
	 <1081549317.2694.25.camel@patsy.fc.hp.com>  <4077535D.6020403@neggie.net>
Content-Type: text/plain
Message-Id: <1081566768.2562.8.camel@wilson.home.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 09 Apr 2004 21:12:49 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-09 at 19:52, John Belmonte wrote:
> The limitation of this interface is that it's not able to call an ACPI 
> method with some arguments and get the return value, correct?

   Yes, that's unfortunately a limitation.  Most of the standard
interfaces either take no parameters or have no return value, so they
fit nicely into this framework.  I'm open to suggestions on how to work
around this.  We could make the store function save off the method
parameters, then the show function would call the method with the saved
parameters and return the results.  Obviously there are some userspace
ordering issues that could make this complicated, but it's easy to code
on the kernel side.  Other ideas?  Thanks,

	Alex

