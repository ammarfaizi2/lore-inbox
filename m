Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbTJGOd7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 10:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbTJGOd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 10:33:59 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:50666 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id S262400AbTJGOd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 10:33:58 -0400
Date: Tue, 07 Oct 2003 09:33:45 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dump read-only anonymous memory in core files
Message-ID: <3120000.1065537225@baldur.austin.ibm.com>
In-Reply-To: <Pine.LNX.4.44.0310070155110.1749-100000@home.osdl.org>
References: <Pine.LNX.4.44.0310070155110.1749-100000@home.osdl.org>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, October 07, 2003 02:06:34 -0700 Linus Torvalds
<torvalds@osdl.org> wrote:

> What about shared mappings (that test should be VM_MAYSHARE)?
> 
> My inclination would be to not dump them if they are backed by a file, 
> even if the mmap is writable.

All shared areas are 'file backed' but some of them are only backed by
shmfs.  I think we should at least dump those areas since they can't be
retrieved later.  I agree it'd be reasonable to not dump areas backed by
real files, but it'd require a simple way to distinguish them from
shmfs-backed areas.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

