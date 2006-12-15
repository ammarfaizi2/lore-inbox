Return-Path: <linux-kernel-owner+w=401wt.eu-S1752136AbWLOOEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbWLOOEq (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 09:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbWLOOEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 09:04:46 -0500
Received: from lazybastard.de ([212.112.238.170]:49971 "EHLO
	longford.lazybastard.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbWLOOEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 09:04:45 -0500
Date: Fri, 15 Dec 2006 14:00:57 +0000
From: =?utf-8?B?SsO2cm4=?= Engel <joern@lazybastard.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/3] ensure unique i_ino in filesystems without permanent inode numbers (introduction)
Message-ID: <20061215140057.GF30508@lazybastard.org>
References: <457891E7.10902@redhat.com> <45829D94.1090304@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45829D94.1090304@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 December 2006 08:05:24 -0500, Jeff Layton wrote:
> Jeff Layton wrote:
> > Apologies for the long email, but I couldn't come up with a way to explain
> > this in fewer words. Many filesystems that are part of the linux kernel
> > have problems with how they have assign out i_ino values:
> >
> 
> If there are no further comments/suggestions on this patchset, I'd like to
> ask Andrew to add it to -mm soon and target getting it rolled into 2.6.21.

I'm still unsure whether idr has a sufficient advantage over simply
hashing the inodes.  Hch has suggested that keeping the hashtable
smaller is good for performance.  But idr adds new complexity, which
should be avoided on its own right.  So is the performance benefit big
enough to add more complexity?  Is it even measurable?

Jörn

-- 
Fancy algorithms are buggier than simple ones, and they're much harder
to implement. Use simple algorithms as well as simple data structures.
-- Rob Pike
