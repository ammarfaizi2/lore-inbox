Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262649AbVA0P4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbVA0P4n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 10:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbVA0P4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 10:56:43 -0500
Received: from speedy.student.utwente.nl ([130.89.163.131]:65413 "EHLO
	speedy.student.utwente.nl") by vger.kernel.org with ESMTP
	id S262649AbVA0P4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 10:56:36 -0500
Date: Thu, 27 Jan 2005 16:56:34 +0100
From: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1: fuse patch needs new libs
Message-ID: <20050127155634.GA6476@speedy.student.utwente.nl>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050125000339.GA610@speedy.student.utwente.nl> <41F90C85.5090705@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F90C85.5090705@tmr.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 10:45:09AM -0500, Bill Davidsen wrote:
> Sytse Wielinga wrote:
> >It is great that this is fixed, don't remove it, but it does require the fuse
> >libs to be updated at the same time, or opening dirs for listings will break
> >like this:
> >
> >open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = -1 ENOSYS (Function
> >not implemented)
> >
> >As I personally like for my ls to keep on working, and I assume others will,
> >too, I would appreciate it if you could add a warning to your announcements the
> >following one or two weeks or so, so that people can remove this patch if they
> >don't want to update their libs.
> 
> By any chance would this also break perl programs which readdir?

Of course; I haven't tested it, but the actual ioctls aren't working anymore,
so it's not even _possible_ to get them to work with this patch and an old
version of the fuse libs, even with perl bindings, which go through the fuse
libs anyway.

    Sytse
