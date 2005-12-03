Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbVLCBih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVLCBih (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 20:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbVLCBih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 20:38:37 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:45776 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751134AbVLCBih
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 20:38:37 -0500
Date: Sat, 3 Dec 2005 01:38:33 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Vinay Venkataraghavan <raghavanvinay@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: copy_from_user/copy_to_user question
Message-ID: <20051203013833.GG27946@ftp.linux.org.uk>
References: <20051202224025.39396.qmail@web32108.mail.mud.yahoo.com> <1133572199.32583.93.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133572199.32583.93.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 08:09:59PM -0500, Steven Rostedt wrote:
> > Secondly, they seem to use memcpy as opposed to using
> > copy_to_user/copy_from_user which is also very
> > dangerous.
> 
> If they are grabbing data from user context into kernel (or vise versa)
> that could easily cause an oops.  Not to mention it is a security risk.

Not to mention it simply won't work on a many platforms, no matter what...
