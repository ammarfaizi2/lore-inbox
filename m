Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263442AbUCTPXo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 10:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263443AbUCTPXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 10:23:44 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:24254 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263442AbUCTPXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 10:23:43 -0500
Date: Sat, 20 Mar 2004 16:23:28 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040320152328.GA8089@wohnheim.fh-wedel.de>
References: <20040320083411.GA25934@wohnheim.fh-wedel.de> <s5gznab4lhm.fsf@patl=users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <s5gznab4lhm.fsf@patl=users.sf.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 March 2004 10:03:05 -0500, Patrick J. LoPresti wrote:
> 
> What happens if the disk fills while you are making the copy?  Will
> open(2) on an *existing file* then return ENOSPC?

Correct.  It would be possible to always succeed and return -ENOSPC
on every write().  But then mmap() has the same problem again, so
serious headache would be the only gain from this little excercise.

> I do not think you can implement this without changing the interface
> to open(2).  Which means applications have to be made aware of it
> anyway.  Which means you might as well leave your implementation as-is
> and let userspace worry about creating the copy (and dealing with the
> resulting errors).

Good point.  Vote is now 2:0 for the simple approach.

Jörn

-- 
"Translations are and will always be problematic. They inflict violence 
upon two languages." (translation from German)
