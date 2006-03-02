Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWCBLyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWCBLyY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 06:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWCBLyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 06:54:24 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37576 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750823AbWCBLyX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 06:54:23 -0500
Date: Thu, 2 Mar 2006 11:54:22 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: s_vfs_rename_sem and cifs (was Re: Possible deadlock in vfs layer, namei.c)
Message-ID: <20060302115422.GY27946@ftp.linux.org.uk>
References: <b6fcc0a0603020347r32567ae9l1fe4495059149449@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6fcc0a0603020347r32567ae9l1fe4495059149449@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 03:47:50AM -0800, Alexey Dobriyan wrote:
> On Wed, Mar 01, 2006 at 06:46:42PM -0800, Joshua Hudson wrote:
> > from namei.c (function: lock_rename), rename takes:
> > 1. s_vfs_rename_sem,
> 
> Speaking of s_vfs_rename_sem, does cifs usage of it despite explicit
> warning at fs.h
> was found to be legal?

Legal as in "works until anything changes in VFS-internal locking".
Not legal as in "not promised to keep working".
Dumb in all respects.
