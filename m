Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269986AbUJHOI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269986AbUJHOI0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 10:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269990AbUJHOI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 10:08:26 -0400
Received: from ida.rowland.org ([192.131.102.52]:2564 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S269991AbUJHOHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 10:07:31 -0400
Date: Fri, 8 Oct 2004 10:07:29 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Power parents
In-Reply-To: <1097189945.16223.8.camel@gaston>
Message-ID: <Pine.LNX.4.44L0.0410081004540.1005-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2004, Benjamin Herrenschmidt wrote:

> > I see that the power tree agrees pretty much with the device tree, but
> > there is the possibility of having a different parent pointer.  However
> > the device_pm_set_parent() routine isn't called anywhere in the kernel.  
> > Does that mean it can be eliminated, making the two trees identical?
> 
> Currently the trees are identical yes. I may still want to "insert"
> special nodes in the Power tree though...

My reason for asking is because having special parent pointers like that,
without corresponding children pointers, makes it impossible to guarantee
that parents aren't suspended until after their children when doing a
selective suspend.

What sort of special nodes are you thinking of inserting, and how would 
they affect selective suspend?

Alan Stern

