Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965664AbWKGSHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965664AbWKGSHY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 13:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965675AbWKGSHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 13:07:24 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:55517 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S965664AbWKGSHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 13:07:23 -0500
Date: Tue, 7 Nov 2006 19:07:05 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: Jeff Layton <jlayton@redhat.com>, Eric Sandeen <sandeen@redhat.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels that offer x86 compatability
Message-ID: <20061107180705.GD29746@wohnheim.fh-wedel.de>
References: <20061106182222.GO27140@parisc-linux.org> <1162838843.12129.8.camel@dantu.rdu.redhat.com> <20061106202313.GA691@wohnheim.fh-wedel.de> <454FA032.1070008@redhat.com> <20061106211134.GB691@wohnheim.fh-wedel.de> <454FAAF8.8080707@redhat.com> <1162914966.28425.24.camel@dantu.rdu.redhat.com> <20061107172835.GB15629@wohnheim.fh-wedel.de> <20061107174217.GA29746@wohnheim.fh-wedel.de> <1162921983.8123.22.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1162921983.8123.22.camel@kleikamp.austin.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 November 2006 11:53:03 -0600, Dave Kleikamp wrote:
> On Tue, 2006-11-07 at 18:42 +0100, Jörn Engel wrote:
> > 
> > Jfs really surprised me.  It appears as if it just takes the number
> > returned from new_inode in some cases - unbelievable.
> 
> jfs set it in diInitInode() (pardon the uglyMixedCaps), which is called
> in several places under diAlloc().  diAlloc() is called after
> new_inode() for most inodes.  The exceptions are for special inodes,
> which also initialize i_ino in some manner.

Yes, even I see it now.  Thanks for clearing that up.

Jörn

-- 
Joern's library part 10:
http://blogs.msdn.com/David_Gristwood/archive/2004/06/24/164849.aspx
