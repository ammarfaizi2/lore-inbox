Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263139AbTDRQlK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 12:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbTDRQlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 12:41:10 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:59314 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263139AbTDRQlK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 12:41:10 -0400
Date: Fri, 18 Apr 2003 09:55:06 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries.Brouwer@cwi.nl, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct loop_info64
Message-ID: <20030418165506.GA6834@kroah.com>
References: <UTC200304181304.h3ID4tU00820.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0304180922370.2950-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304180922370.2950-100000@home.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 18, 2003 at 09:26:08AM -0700, Linus Torvalds wrote:
> 
> We should literally have the rule that any user-visible data structures 
> cannot use _any_ types other than u8/u16/u32/u64 (and _maybe_ the signed 
> ones, if there is any real reason to).

I thought we did have such a rule.  Well, it's unwritten I guess...
I'll go knock up a Documentation/user_to_kernel_datatypes.txt file to
set this in stone.

Oh, and shouldn't we be using the "__*" style types for crossing the
user/kernel boundry (__u8, __u16, __u32, etc.)?  I thought that is what
those versions were for.

thanks,

greg k-h
