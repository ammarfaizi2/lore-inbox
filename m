Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUIDWbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUIDWbY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 18:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUIDWbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 18:31:24 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:52183 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264098AbUIDWbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 18:31:23 -0400
Subject: Re: [PATCH 4/4][diskdump] x86-64 support
From: Lee Revell <rlrevell@joe-job.com>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <9AC48F3A62CFC4indou.takao@soft.fujitsu.com>
References: <20040828112324.B8000@infradead.org>
	 <9AC48F3A62CFC4indou.takao@soft.fujitsu.com>
Content-Type: text/plain
Message-Id: <1094337090.6575.474.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 04 Sep 2004 18:31:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 05:10, Takao Indoh wrote:
> >As in the scsi code spin_is_locked checks are bogus and racy.  Only
> >a spin_trylock would be safe.  hd can't be NULL.
> 
> Could you explain to me why spin_is_locked is not safe?
> 

Say you have a door with a lock, and someone on the other side.  You 
look at the lock, see that it's unlocked, then open the door.  You
cannot guarantee that the door will open because the person on the other
side could have locked it between the time you looked and turned the
handle.

The only way to know for sure whether the door is locked is to turn the
handle and see if it opens.

Lee

