Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUCLJTd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 04:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbUCLJTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 04:19:33 -0500
Received: from [66.35.79.110] ([66.35.79.110]:12942 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261210AbUCLJTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 04:19:30 -0500
Date: Fri, 12 Mar 2004 01:19:18 -0800
From: Tim Hockin <thockin@hockin.org>
To: Greg KH <greg@kroah.com>
Cc: Eric Brower <ebrower@usa.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ethtool.h should use userspace-accessible types
Message-ID: <20040312091918.GB10549@hockin.org>
References: <40511868.4060109@usa.net> <20040312023551.GA25331@hockin.org> <20040312045756.GA30714@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040312045756.GA30714@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 08:57:56PM -0800, Greg KH wrote:
> 	u8 means an unsigned 8 bit variable within the kernel.
> 	__u8 means an unsigned 8 bit variable both within the kernel and
> 	in userspace.  Use the __ forms when describing data structures
> 	or variables that cross the userspace/kernelspace boundry in
> 	order to get everything correct.

The only problem is that this is a RETARDED precedent. __foo means the 
"internal" version of foo. Within the kernel __foo often means the version
of foo without "the lock".

POSIX defines any type beginning with _ as part of the implementation.
IMHO, no userspace app should *ever* need a type that starts with _ or __.
It's just dumb.  If the width matters, define it as a width specific type.
If it doesn't define it as an int/short/whatever.  The fact that it isn't
obvious what is or is not kernel-only is an entirely separate issue.

> Becides, something like u8 is a zillion times saner than uint8_t, don't
> you think?  :)

As much as uint8_t is a pain in the ass to type, at least it is clear and
obvious and standard, don't you think? :)

