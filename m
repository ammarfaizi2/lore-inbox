Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269686AbUICNWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269686AbUICNWr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 09:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269675AbUICNWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 09:22:46 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:63700 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S269687AbUICNWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 09:22:13 -0400
Message-ID: <41386FB7.2060804@cs.aau.dk>
Date: Fri, 03 Sep 2004 15:20:55 +0200
From: =?ISO-8859-1?Q?Kristian_S=F8rensen?= <ks@cs.aau.dk>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040619)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: umbrella-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Umbrella-devel] Re: Getting full path from dentry in LSM hooks
References: <41385FA5.806@cs.aau.dk> <20040903133238.A4145@infradead.org> <413865B4.7080208@cs.aau.dk> <20040903140449.A4253@infradead.org>
In-Reply-To: <20040903140449.A4253@infradead.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Fri, Sep 03, 2004 at 02:38:12PM +0200, Kristian Sørensen wrote:
> 
>>Is there another way to get it? We also get an inodepointer from the LSM 
>>hook. As far as I know, the file struct has an entry called vfs_mount, 
>>which has an entry called root_mnt - could this be used? (and if so, how 
>>do I get from the Inode to the file struct? :-/ )
> 
> 
> Witch a struct file you can use d_path which gives you a canonical path
> in the _current_ _namespace_.
But we do not have a struct file - just an inode or a dentry :((


> What do you want to do with the path anyway?
We are working on a project called Umbrella, (umbrella.sf.net) which 
implements processbased mandatory accesscontrol in the Linux kernel. 
This access control is controlled by "restriction", e.g. by restricting 
  some process from accessing any given file or directory.

E.g. if a root owned process is restricted from accessing /var/www, and 
the process is compromised by an attacker, no mater what he does, he 
would not be able to access this directory.


KS
