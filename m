Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946056AbWBORgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946056AbWBORgF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 12:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946055AbWBORgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 12:36:05 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37524 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1946056AbWBORgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 12:36:03 -0500
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] fix handling of st_nlink on procfs root
References: <E1F6vyO-00009r-3a@ZenIV.linux.org.uk>
	<m1slql3rn2.fsf@ebiederm.dsl.xmission.com>
	<20060215103911.GL27946@ftp.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 15 Feb 2006 10:35:08 -0700
In-Reply-To: <20060215103911.GL27946@ftp.linux.org.uk> (Al Viro's message of
 "Wed, 15 Feb 2006 10:39:11 +0000")
Message-ID: <m11wy4ttir.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> writes:

> On Wed, Feb 15, 2006 at 02:20:17AM -0700, Eric W. Biederman wrote:
>> And it is actually wrong.  It fails to take into account the static
>> /proc entries.
>> > +	stat->nlink = proc_root.nlink + nr_processes();
>
> The hell it does. See ^^^^^^^^^^^^^^ this.

Right.  Sorry.  I had a similar issue and when I check your patch for the
same problem somehow I thought proc_root was a struct inode and not a
struct proc_dir_entry. 

Eric

