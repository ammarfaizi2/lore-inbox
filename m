Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751737AbVJTEUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbVJTEUk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 00:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbVJTEUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 00:20:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:32184 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751736AbVJTEUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 00:20:40 -0400
Date: Wed, 19 Oct 2005 21:04:19 -0700
From: Greg KH <greg@kroah.com>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Rick Niles <fniles@mitre.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 26 ways to set a device driver variable from userland
Message-ID: <20051020040419.GA9179@kroah.com>
References: <1129741246.25383.23.camel@gnupooh.mitre.org> <4C7CA605-435C-4B16-A3A1-44EF247BF5B0@mac.com> <435691EF.8070406@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435691EF.8070406@nortel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2005 at 12:35:27PM -0600, Christopher Friesen wrote:
> Kyle Moffett wrote:
> 
> >>(4) sysfs
> 
> >This is ideal for almost all device driver purposes.
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

Take a look at configfs, as part of the ocfs2 patches in the -mm tree.
It is set up to help solve this using a filesystem much like sysfs.

thanks,

greg k-h
