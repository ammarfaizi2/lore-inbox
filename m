Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUFIX6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUFIX6Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 19:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUFIX6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 19:58:25 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:47574 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264443AbUFIX6Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 19:58:24 -0400
Subject: Re: Increasing number of inodes after format?
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <40C62F2F.4090801@techsource.com>
References: <40C62F2F.4090801@techsource.com>
Content-Type: text/plain
Message-Id: <1086811650.26565.50.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 09 Jun 2004 15:07:30 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-08 at 16:27, Timothy Miller wrote:
> I was involved in a discussion a while back where it was explained that 
> ext2/3 allocate a certain maximum number of inodes at format time, and 
> you cannot increase that number later.
> 
> It was also mentioned that one or more of the journaling file systems 
> (XFS, JFS, Reiser, etc.) either dynamically allocated inodes or could 
> increase the maximum later if the pre-allocated set got used up.
> 
> Could someone please repeat for me which filesystems have dynamic 
> maximum inode counts?

JFS dynamically allocates inodes as needed.  An inode extent (consisting
of 32 inodes) will also be freed if all of its inodes are freed.
-- 
David Kleikamp
IBM Linux Technology Center

