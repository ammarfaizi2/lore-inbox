Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269667AbUICMpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269667AbUICMpB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 08:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269668AbUICMpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 08:45:01 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:19841
	"EHLO x30.random") by vger.kernel.org with ESMTP id S269667AbUICMop
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 08:44:45 -0400
Date: Fri, 3 Sep 2004 14:43:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Kristian =?iso-8859-1?Q?S=F8rensen?= <ks@cs.aau.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       umbrella-devel@lists.sourceforge.net
Subject: Re: Getting full path from dentry in LSM hooks
Message-ID: <20040903124305.GC8557@x30.random>
References: <41385FA5.806@cs.aau.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41385FA5.806@cs.aau.dk>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 02:12:21PM +0200, Kristian Sørensen wrote:
> Hi!
> 
> I have a short question, concerning how to get the full path of a file 
> from a LSM hook.
> 
> - If the "file" of the dentry is located in the root filesystem: no
>   problem - simply traverse the dentrys, to generate the path.
> 
> - If the "file" is mounted from another partition, you do not get the
>   full path by traversing the dentrys.
> 
> Example:
> If we have a system with a normal root (/) and a seperate boot partition 
> (mounted on /boot :). In the LSM hook inode_permission, you get the 
> arguments (struct inode *inode, int mask, struct nameidata *nd).
> Finding the path, we traverse the dentrys from (nd->dentry). But if the 
> inode is a file in /boot we only get the filename (e.g. kernel-2.6.8.1 
> instead of /boot/kernel-2.6.8.1)
> 
> 
> Can some one reveal the trick to get the full path nomater if the 
> filesystem is root or mounted elsewhere in the filesystem?

fix d_path, I need that too ;)
