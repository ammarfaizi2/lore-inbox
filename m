Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWFMUKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWFMUKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 16:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWFMUKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 16:10:40 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:22198 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932185AbWFMUKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 16:10:39 -0400
Date: Tue, 13 Jun 2006 22:10:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Avi Kivity <avi@argo.co.il>
cc: Theodore Tso <tytso@mit.edu>, Nathan Scott <nathans@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC]  Slimming down struct inode
In-Reply-To: <448EFF23.6070703@argo.co.il>
Message-ID: <Pine.LNX.4.61.0606132209420.11918@yvahk01.tjqt.qr>
References: <20060613174407.GA6561@thunk.org> <448EFF23.6070703@argo.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > if (inode->i_ops->getblksize)
>> >     return inode->i_ops->getblksize(inode);
>> > else
>> > return inode->i_sb->s_blksize;
>> > 
>> > Trading some efficiency for space.
>> 
>> Yep, that was what I was planning on doing....
>> 
>
> Maybe
>
> if (inode->i_sb->s_blksize)
>   return inode->i_sb->s_blksize;
> else
> ...
>
> is a tiny little bit faster...
>

The compiler will anyway pick the one it thinks is better by itself.
Influence can be taken using likely/unlikely of course.


Jan Engelhardt
-- 
