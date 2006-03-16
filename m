Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWCPX5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWCPX5Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 18:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWCPX5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 18:57:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50661 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964909AbWCPX5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 18:57:24 -0500
Date: Thu, 16 Mar 2006 15:57:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Michael Kerrisk <mtk-manpages@gmx.net>
cc: akpm@osdl.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       janak@us.ibm.com, viro@ftp.linux.org.uk, hch@lst.de, ak@muc.de,
       paulus@samba.org
Subject: Re: [PATCH] unshare: Cleanup up the sys_unshare interface before we
 are committed.
In-Reply-To: <26439.1142552064@www064.gmx.net>
Message-ID: <Pine.LNX.4.64.0603161555210.3618@g5.osdl.org>
References: <1359.1142546753@www064.gmx.net> <26439.1142552064@www064.gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Mar 2006, Michael Kerrisk wrote:
> > 
> > My personal opinion is that having a different set of flags is more 
> > confusing 
> 
> How is it confusing?  And who is it confusing for?

It's confusing because
 - it's just more flags to keep track of
 - it's all the same issues that clone() has
 - it's an opportunity for future incoherence

> It will potentially require kernel developers to think for just 
> a moment about what is going on.  But why care about them -- 
> they don't have to *use* this interface; userland programmers do.

All the confusion is equally a userland issue, don't try to just enforce 
your own opinions as somehow being "facts" by repeating them over and over 
again.

			Linus
