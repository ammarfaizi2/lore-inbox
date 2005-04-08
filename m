Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbVDHBwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbVDHBwj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 21:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbVDHBwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 21:52:39 -0400
Received: from peabody.ximian.com ([130.57.169.10]:64900 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262542AbVDHBwg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 21:52:36 -0400
Subject: Re: [patch] inotify for 2.6.11
From: Robert Love <rml@novell.com>
To: Rusty Lynch <rusty.lynch@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <pan.2005.04.08.01.37.42.462474@intel.com>
References: <3Q7wT-4HJ-11@gated-at.bofh.it> <3Q7wT-4HJ-13@gated-at.bofh.it>
	 <3Q7wT-4HJ-15@gated-at.bofh.it> <3Q7wT-4HJ-17@gated-at.bofh.it>
	 <3Q7wT-4HJ-19@gated-at.bofh.it> <3Q7wT-4HJ-21@gated-at.bofh.it>
	 <3Q7wT-4HJ-9@gated-at.bofh.it>  <pan.2005.04.08.01.37.42.462474@intel.com>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 21:52:35 -0400
Message-Id: <1112925155.23323.2.camel@phantasy.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-07 at 18:37 -0700, Rusty Lynch wrote:

> Looking into this a little more I realized that the lack of /proc
> notifications (for processes coming and going) is a common problem anytime
> a file is modified without going through the VFS.  Other examples are
> remote file changes on a mounted NFS partition, remote file changes on a
> mounted cluster filesystem (like ocfs or gfs), and just about any virtual
> file system where the kernel is adding/deleting/modifying files from below
> the VFS.

Indeed it is.  But none of those are anything that we care about (except
maybe /proc).

The problem of changes on remote filesystems is solved by FAM.

	Robert Love


