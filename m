Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbUCLRQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 12:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbUCLRQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 12:16:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8374 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262335AbUCLRQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 12:16:24 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ethtool.h should use userspace-accessible types
References: <40511868.4060109@usa.net>
	<m17jxqf2xf.fsf@ebiederm.dsl.xmission.com>
	<4051EB42.8060903@pobox.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Mar 2004 10:06:08 -0700
In-Reply-To: <4051EB42.8060903@pobox.com>
Message-ID: <m13c8ef11b.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> Eric W. Biederman wrote:
> > Eric Brower <ebrower@usa.net> writes:
> >
> >>Attached is a patch to 2.4's ethtool.h to use appropriate,
> userspace-accessible
> 
> >>data types (__u8 and friends, rather than u8 and friends).
> > Why there is no #ifdef __KERNEL__ in this header to make it userspace
> > safe.
> 
> 
> Because it's not needed.

I think we are in agreement.

My intent was to say:  Why change the types when there is no #ifdef
__KERNEL__ in the header.  With no #ifdef __KERNEL__ it exports
definitions that are private to the kernel making it not safe for
userspace to use.  With kernel private definitions in there it will
generate name space pollution if included by user space.

Eric
