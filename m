Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965565AbWKGRE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965565AbWKGRE4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 12:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965562AbWKGRE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 12:04:56 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:22709 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S965559AbWKGREy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 12:04:54 -0500
Date: Tue, 7 Nov 2006 18:04:54 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jeff Layton <jlayton@redhat.com>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels that offer x86 compatability
Message-ID: <20061107170454.GA15629@wohnheim.fh-wedel.de>
References: <1162836725.6952.28.camel@dantu.rdu.redhat.com> <20061106182222.GO27140@parisc-linux.org> <1162838843.12129.8.camel@dantu.rdu.redhat.com> <20061106202313.GA691@wohnheim.fh-wedel.de> <454FA032.1070008@redhat.com> <20061106211134.GB691@wohnheim.fh-wedel.de> <454FAAF8.8080707@redhat.com> <1162914966.28425.24.camel@dantu.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1162914966.28425.24.camel@dantu.rdu.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 November 2006 10:56:06 -0500, Jeff Layton wrote:
> 
> Here's a more involved (again, untested) patch. I turned new_inode into
> a wrapper for a new function (new_inode_autonum). If the autonum arg is
> set, then we should get back a unique i_ino.

A good start.  You didn't convert any callers yet, so I did a quick
poll.  Turned out that out of 76 callers 37 explicitly set i_ino, 1
(fat) calls iunique itself and 38 look at first glance as if they
didn't set i_ino.  xfs and jfs were in the latter category, which just
proved I didn't look too closely.

Anyway, the distribution is fairly even, so I agree with your choice
of default behaviour.

JÃ¶rn

-- 
Schrödinger's cat is <BLINK>not</BLINK> dead.
-- Illiad
