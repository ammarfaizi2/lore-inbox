Return-Path: <linux-kernel-owner+w=401wt.eu-S1752702AbWLOPBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702AbWLOPBY (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 10:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752701AbWLOPBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 10:01:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55096 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752700AbWLOPBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 10:01:23 -0500
Message-ID: <4582B8AF.9060707@redhat.com>
Date: Fri, 15 Dec 2006 10:01:03 -0500
From: Jeff Layton <jlayton@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: =?UTF-8?B?SsO2cm4gRW5nZWw=?= <joern@lazybastard.org>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/3] ensure unique i_ino in filesystems without permanent
 inode numbers (introduction)
References: <457891E7.10902@redhat.com> <45829D94.1090304@redhat.com> <20061215140057.GF30508@lazybastard.org>
In-Reply-To: <20061215140057.GF30508@lazybastard.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
 > On Fri, 15 December 2006 08:05:24 -0500, Jeff Layton wrote:
 >> Jeff Layton wrote:
 >>> Apologies for the long email, but I couldn't come up with a way to explain
 >>> this in fewer words. Many filesystems that are part of the linux kernel
 >>> have problems with how they have assign out i_ino values:
 >>>
 >> If there are no further comments/suggestions on this patchset, I'd like to
 >> ask Andrew to add it to -mm soon and target getting it rolled into 2.6.21.
 >
 > I'm still unsure whether idr has a sufficient advantage over simply
 > hashing the inodes.  Hch has suggested that keeping the hashtable
 > smaller is good for performance.  But idr adds new complexity, which
 > should be avoided on its own right.  So is the performance benefit big
 > enough to add more complexity?  Is it even measurable?
 >
 > Jörn
 >


A very good question. Certainly, just hashing them would be a heck of a
lot simpler. That was my first inclination when I looked at this, but as
you said, HCH NAK'ed that idea stating that it would bloat out the
hashtable. I tend to think that it's probably not that significant, but
that might very much depend on workload.

I'm OK with either approach, though I'd like to have some sort of buyin
from Christoph on hashing the inodes before I start working on patches to
do that.

Christoph, care to comment?

-- Jeff


