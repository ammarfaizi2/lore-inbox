Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbVJGDGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVJGDGS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 23:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbVJGDGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 23:06:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:25325 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751364AbVJGDGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 23:06:17 -0400
Date: Thu, 6 Oct 2005 19:56:44 -0700
From: Greg KH <greg@kroah.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] gfp flags annotations
Message-ID: <20051007025644.GA11132@kroah.com>
References: <20050905160313.GH5155@ZenIV.linux.org.uk> <20050905164712.GI5155@ZenIV.linux.org.uk> <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk> <20050912191744.GN25261@ZenIV.linux.org.uk> <20050912192049.GO25261@ZenIV.linux.org.uk> <20050930120831.GI7992@ftp.linux.org.uk> <20051004203009.GQ7992@ftp.linux.org.uk> <20051005202904.GA27229@mipter.zuzino.mipt.ru> <20051006201534.GX7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006201534.GX7992@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 09:15:34PM +0100, Al Viro wrote:
> Speaking of that...  IMO we should do the following:
> 
> a) typedef unsigned int __nocast gfp_t;
> b) replace __nocast uses for gfp flags with gfp_t - it gives exactly the same
> warnings as far as sparse is concerned, doesn't change generated code and
> documents what's going on far better.  If we are using __nocast for anything
> else - sure, let it stay.
> c) then replace __nocast in declaration of gfp_t with __bitwise [*], add
> force cast to gfp_t to definitions of __GFP_... and deal with resulting
> warnings.
> 
> Objections?

None from me, this will be a good thing to have.

thanks,

greg k-h
