Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWCQFnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWCQFnN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 00:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWCQFnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 00:43:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31169 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750759AbWCQFnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 00:43:12 -0500
Date: Thu, 16 Mar 2006 21:42:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Michael Kerrisk <mtk-manpages@gmx.net>
cc: akpm@osdl.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       janak@us.ibm.com, viro@ftp.linux.org.uk, hch@lst.de, ak@muc.de,
       paulus@samba.org
Subject: Re: [PATCH] unshare: Cleanup up the sys_unshare interface before we
 are committed.
In-Reply-To: <29085.1142557915@www064.gmx.net>
Message-ID: <Pine.LNX.4.64.0603162140190.3618@g5.osdl.org>
References: <Pine.LNX.4.64.0603161555210.3618@g5.osdl.org>
 <29085.1142557915@www064.gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Mar 2006, Michael Kerrisk wrote:
> 
> >  - it's all the same issues that clone() has
> 
> At the moment, but possibly not in the future (if one day
> usnhare() needs a flag that has no analogue in clone()).

I don't believe that.

If we have something we might want to unshare, that implies by definition 
that it was something we wanted to conditionally share in the first place.

IOW, it ends up being something that would be a clone() flag.

So I really do believe that there is a fundamental 1:1 between the flags. 
They aren't just "similar". They are very fundamentally about the same 
thing, and giving two different names to the same thing is CONFUSING.

		Linus
