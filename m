Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVKMVvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVKMVvO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 16:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbVKMVvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 16:51:14 -0500
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:42244 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S1750723AbVKMVvM (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 13 Nov 2005 16:51:12 -0500
To: jmerkey <jmerkey@soleranetworks.com>
Cc: Nikita Danilov <nikita@clusterfs.com>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: Severe VFS Performance Issues 2.6 with > 95000 directory entries
References: <4376B787.9000108@soleranetworks.com>
	<17271.13688.298525.23645@gargle.gargle.HOWL>
	<4377A999.7090305@soleranetworks.com>
From: Douglas McNaught <doug@mcnaught.org>
Date: Sun, 13 Nov 2005 16:50:56 -0500
In-Reply-To: <4377A999.7090305@soleranetworks.com> (jmerkey@soleranetworks.com's message of "Sun, 13 Nov 2005 14:01:13 -0700")
Message-ID: <m2u0egp67z.fsf@Douglas-McNaughts-Powerbook.local>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmerkey <jmerkey@soleranetworks.com> writes:

> Nikita Danilov wrote:
>
>>Jeff V. Merkey writes:
>> > > The subject line speaks for itself.   This is using standard VFS
>> readdir > and lookup calls through the VFSwith ftp.  Very poor. 
>>
>>Reiser4 works fine with 100M entries in a directory, so VFS is not a
>>bottleneck here.
>>  
>>
>
> how about with ftp running on top? Try running FTP in directory with
> 100M entries. See how long it takes to return the data to
> the remote client for a dir listing.

What filesystem are you using?  If it's ext3 without dirindex turned
on, that would definitely explain it.

-Doug
