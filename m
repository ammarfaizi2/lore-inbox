Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbUCLE6F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 23:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbUCLE6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 23:58:05 -0500
Received: from mail.kroah.org ([65.200.24.183]:20933 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261958AbUCLE6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 23:58:02 -0500
Date: Thu, 11 Mar 2004 20:57:56 -0800
From: Greg KH <greg@kroah.com>
To: Tim Hockin <thockin@hockin.org>
Cc: Eric Brower <ebrower@usa.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ethtool.h should use userspace-accessible types
Message-ID: <20040312045756.GA30714@kroah.com>
References: <40511868.4060109@usa.net> <20040312023551.GA25331@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040312023551.GA25331@hockin.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 06:35:51PM -0800, Tim Hockin wrote:
> On Thu, Mar 11, 2004 at 05:54:48PM -0800, Eric Brower wrote:
> > Attached is a patch to 2.4's ethtool.h to use appropriate, 
> > userspace-accessible data types (__u8 and friends, rather than u8 and 
> > friends).
> 
> if we *know* the width of them, why don't we just use C99 standard types in
> *both* places?  I've never quite grokked why we need u8 and __u8 and all the
> variants, when we now have uint8_t.  I mean, at least it's standardized.
> 
> Anyone have a logical answer?

Yes.
	u8 means an unsigned 8 bit variable within the kernel.
	__u8 means an unsigned 8 bit variable both within the kernel and
	in userspace.  Use the __ forms when describing data structures
	or variables that cross the userspace/kernelspace boundry in
	order to get everything correct.

Becides, something like u8 is a zillion times saner than uint8_t, don't
you think?  :)

I remember saying that I would document this better a long time ago, as
it comes up every other month or so.  Sorry for not doing it yet...

thanks,

greg k-h
