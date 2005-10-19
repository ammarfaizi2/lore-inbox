Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751634AbVJSXjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbVJSXjf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 19:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbVJSXjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 19:39:35 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:30445 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751628AbVJSXje
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 19:39:34 -0400
Subject: Re: 26 ways to set a device driver variable from userland
From: Matt Helsley <matthltc@us.ibm.com>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Rick Niles <fniles@mitre.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <435691EF.8070406@nortel.com>
References: <1129741246.25383.23.camel@gnupooh.mitre.org>
	 <4C7CA605-435C-4B16-A3A1-44EF247BF5B0@mac.com>
	 <435691EF.8070406@nortel.com>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 16:32:41 -0700
Message-Id: <1129764761.3282.9.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-19 at 12:35 -0600, Christopher Friesen wrote:
> Kyle Moffett wrote:
> 
> >> (4) sysfs
> 
> > This is ideal for almost all device driver purposes.
> 
> The one thing that I have yet to see a good solution for is 
> transaction-based operations, where userspace passes in something (could 
> be a command, a new value, a query, etc.) and expects some data in return.
> 
> The ioctl() method is ideal for this, passing down a binary struct with 
> a command/query member, and the driver fills in the rest of the struct 
> based on the commnd.
> 
> How do you do this cleanly via sysfs?  It seems like you either double 
> the number of syscalls (write to one file, read from another) or else 
> you need to have sysfs files for every possible query/command, so that 
> the input becomes implicitly encoded in the file that you are reading. 
> This could end up creating a large number of files depending on the 
> range of inputs.
> 
> Are there any other standard ways to do this?
> 
> Chris

	Perhaps a connector would be appropriate here. Userspace could send a
netlink message to the connector with the query/command and the
connector could respond by sending appropriate results back to
userspace.

Cheers,
	-Matt Helsley

