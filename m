Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbVKJNni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVKJNni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 08:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbVKJNni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 08:43:38 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:47840 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750754AbVKJNnh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 08:43:37 -0500
Date: Thu, 10 Nov 2005 13:43:36 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Peter Staubach <staubach@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] handling 64bit values for st_ino]
Message-ID: <20051110134336.GE7992@ftp.linux.org.uk>
References: <20051110003024.GD7992@ftp.linux.org.uk> <437343B1.5000809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437343B1.5000809@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 07:57:21AM -0500, Peter Staubach wrote:
> 
> Has this potential degradation been measured?  This is a lot of extra
> complexity which needs to justified by the resulting performance.

What extra complexity?
 
> >	Fix is pretty cheap and consists of two parts:
> >1) widen struct kstat ->ino to u64, add a macro (check_inumber()) to
> >be used in callers of ->getattr() that want to store ->ino in possibly
> >narrower fields and care about overflows (stuff like sys_old_stat() with
> >its 16bit st_ino clearly doesn't ;-)

> It seems to me that a type with a name which better matches the intended
> semantics would be a better choice than u64.  Even something like ino64_t
> would help file systems maintainers to correctly implement the appropriate
> support.

Why the hell would fs maintainers needs to touch their code at all?
Have you actually read that patches?
