Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751527AbWFJPGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbWFJPGQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 11:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbWFJPGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 11:06:16 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:44475 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751523AbWFJPGP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 11:06:15 -0400
Message-ID: <448ADFE5.4030008@garzik.org>
Date: Sat, 10 Jun 2006 11:06:13 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC]  Slimming down struct inode
References: <E1Foqjw-00010e-Ln@candygram.thunk.org> <20060610110335.GA7959@irc.pl>
In-Reply-To: <20060610110335.GA7959@irc.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Torcz wrote:
> On Fri, Jun 09, 2006 at 07:50:08PM -0400, Theodore Ts'o wrote:
>> So without further ado, here are some ideas of ways that we can slim
>> down struct inode:
>>
>> 1) Move i_blksize (optimal size for I/O, reported by the stat system
>>    call).  Is there any reason why this needs to be per-inode, instead
>>    of per-filesystem?
>>
>> 2) Move i_blkbits (blocksize for doing direct I/O in bits) to struct
>>    super.  Again, why is this per-inode?
> 
>   ZFS filesystem uses dynamic, per-file blocksizes. Some Linux
> filesystem may implement something like this in order to be called
> "modern".

Yep, Sun stole my buckets idea <j/k>  I think ZFS calls them 
"meta-slabs" or somesuch.

See what I posted in the 'continuous inodes' sub-thread.

	Jeff



