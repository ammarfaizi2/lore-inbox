Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbTEIS1U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 14:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbTEIS1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 14:27:20 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:50937 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S263387AbTEIS1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 14:27:16 -0400
Date: Fri, 9 May 2003 11:39:16 -0700
From: Chris Wright <chris@wirex.com>
To: David Howells <dhowells@warthog.cambridge.redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, arjanv@redhat.com,
       viro@parcelfarce.linux.theplanet.co.uk, drepper@redhat.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] New authentication management syscalls
Message-ID: <20030509113916.A29208@figure1.int.wirex.com>
Mail-Followup-To: David Howells <dhowells@warthog.cambridge.redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>, arjanv@redhat.com,
	viro@parcelfarce.linux.theplanet.co.uk, drepper@redhat.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20030509143147.A23197@infradead.org> <552.1052502290@warthog.warthog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <552.1052502290@warthog.warthog>; from dhowells@warthog.cambridge.redhat.com on Fri, May 09, 2003 at 06:44:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Howells (dhowells@warthog.cambridge.redhat.com) wrote:
> 
> I think this might be a better idea than the name of a mountpoint as it would
> then be possible to set the tokens prior to mounting, maybe so that you _can_
> mount.
> 
> I'm thinking a bit of samba here, where authentication information needs to be
> passed upon mounting (workstation/domain, username, password).

How does this map up with Viro's idea of a two stage mount.  IIRC, it
was someting akin to:

fsfd = open(/dev/fs_type/ext2)
write(fd, "device and options, potentially including auth...");
mntfd = open("mntpt");
newmount(fd, mntfd, MNT_ATTACH);

or something like that.  Wouldn't that give you a free form abiility to
talk to the fs driver and authenticate as needed?  Is this plan still
alive?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
