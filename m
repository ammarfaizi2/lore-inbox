Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUDJUnF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 16:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUDJUnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 16:43:05 -0400
Received: from mailhub.hp.com ([192.151.27.10]:964 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S261991AbUDJUnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 16:43:02 -0400
Subject: Re: [ACPI] Re: [PATCH] filling in ACPI method access via sysfs
	namespace
From: Alex Williamson <alex.williamson@hp.com>
To: John Belmonte <john@neggie.net>
Cc: acpi-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <407786C6.7030706@neggie.net>
References: <1081453741.3398.77.camel@patsy.fc.hp.com>
	 <1081549317.2694.25.camel@patsy.fc.hp.com>  <4077535D.6020403@neggie.net>
	 <1081566768.2562.8.camel@wilson.home.net>  <407786C6.7030706@neggie.net>
Content-Type: text/plain
Message-Id: <1081629776.2562.40.camel@wilson.home.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 10 Apr 2004 14:42:57 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-09 at 23:31, John Belmonte wrote:
> 
> You may want to look at the acpi-devel thread "[rfc] generic testing 
> ACPI module", where this issue was discussed 
> (http://sourceforge.net/mailarchive/message.php?msg_id=7455349).

   Ok, I took a look.  The open/write/read/close interface seems to be
the best approach.  It shouldn't be too hard, except the read/write
interfaces don't pass in the attribute pointer like they do for the
show/store interface.  Is this a bug?

   A nice feature of the current implementation is that I have one show
function that reads the method name out of the attribute structure. 
With the bin_file interface, I'd need to have a different read/write
function for every possible method on a kobject.  I also lose the
convenience of being able extend the container structure to meet my
needs.  Am I strecthing the use of the bin_file too far or should these
interfaces pass the attribute pointer?  Thanks,

	Alex

