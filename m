Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbVJBNxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbVJBNxk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 09:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbVJBNxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 09:53:40 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:54790 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751029AbVJBNxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 09:53:39 -0400
Date: Sun, 2 Oct 2005 15:47:02 +0200
From: Willy Tarreau <willy@w.ods.org>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Why no XML in the Kernel?
Message-ID: <20051002134702.GA22601@alpha.home.local>
References: <20051002094142.65022.qmail@web51012.mail.yahoo.com> <433FAD57.7090106@yahoo.com.au> <433FBE59.8000806@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433FBE59.8000806@superbug.co.uk>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2005 at 12:02:49PM +0100, James Courtier-Dutton wrote:
> Nick Piggin wrote:
> 
> >Ahmad Reza Cheraghi wrote:
> >
> >>Can somebody tell me why the Kernel-Development dont
> >>wanne have XML is being used in the Kernel??
> >>
> >
> >Because nobody has come up with a good reason why it
> >should be. Same as anything that isn't in the kernel.
> >
> >Nick
> >
> I have a requirement to pass information from the kernel to user space. 
> The information is passed fairly rarely, but over time extra parameters 
> are added. At the moment we just use a struct, but that means that the 
> kernel and the userspace app have to both keep in step. If something 
> like XML was used, we could implement new parameters in the kernel, and 
> the user space could just ignore them, until the user space is upgraded.
> XML would initially seem a good idea for this, but are there any methods 
> currently used in the kernel that could handle these parameter changes 
> over time.

Yes, look at /proc/meminfo for instance. Everytime you need to return
multiple values from a single file, you can easily do it with one key
per line using the following syntax :

   key: value [value ...]

It's also how SMTP and HTTP works and servers often send data that most
clients simply ignore.

Regards,
Willy

