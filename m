Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbTDOR3r (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 13:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTDOR3r 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 13:29:47 -0400
Received: from granite.he.net ([216.218.226.66]:50450 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S261860AbTDOR3q 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 13:29:46 -0400
Date: Tue, 15 Apr 2003 10:22:57 -0700
From: Greg KH <greg@kroah.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem and solution: 2.5 broke KDE panel (kpanel)
Message-ID: <20030415172257.GA12551@kroah.com>
References: <200304150403_MC3-1-3478-63FB@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304150403_MC3-1-3478-63FB@compuserve.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 03:58:44AM -0400, Chuck Ebbert wrote:
> 
>  When I tried KDE 3.0 on kernel 2.5.66 I got an exception message
> from kpanel.  Everything else worked OK but there was no panel, so
> it wasn't much fun.
> 
>  Solution: boot up 2.4 and remove applets from the panel.  The system
> monitor seems to be the problem -- it faulted when I tried to add it
> back (but the panel kept running.)

The old lmsensors code is now gone from the kernel, so the older sysctl
and /proc code for the i2c sensors is not present anymore.  Could your
configuration be still looking for those files?

thanks,

greg k-h
