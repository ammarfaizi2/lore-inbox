Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265350AbTLNFLn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 00:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265352AbTLNFLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 00:11:42 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:14038 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S265350AbTLNFLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 00:11:40 -0500
Date: Sat, 13 Dec 2003 23:11:37 -0600 (CST)
From: Eric Sandeen <sandeen@sgi.com>
X-X-Sender: sandeen@stout.americas.sgi.com
To: Emilio Gargiulo <emiliogargiulo@supereva.it>
cc: linux-kernel@vger.kernel.org, <linux-xfs@oss.sgi.com>
Subject: Re: 2.4.24-pre1 hangs with XFS on LVM filesystem full
In-Reply-To: <200312131937.10987.emiliogargiulo@supereva.it>
Message-ID: <Pine.LNX.4.44.0312132302520.766-100000@stout.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So you are seeing a hang when you (over)fill the filesystem, if 
I understand correctly?  If there is any chance that you could
test it with XFS to a normal disk (no LVM) or with some other
filesystem with LVM, that might help to narrow down the problem.
Nightly XFS QA tests do check ENOSPC conditions, but perhaps
there is bad interaction with LVM.

You could also get a CVS kernel from oss.sgi.com, or apply
the KDB patch you your kernel, and enter kdb when the system
freezes.  Then you could look at backtraces of the relevant
processes to get an idea of where things are stuck.

-Eric

On Sat, 13 Dec 2003, Emilio Gargiulo wrote:

> Hi
> There is a severe XFS problem with kernel 2.4.24-pre1. If you try to copy a 
> file in a XFS filesystem on LVM bigger than free spaces, the Linux Box will 
> hang. No messages, no warnings, it just freeze. It happens also if the 
> filesystem was not the root filesystem.
> The problem is fully reproducible on 2 different computer, an old K6/400MHz 
> and a P4/2,4GHz.
> 
> If i can do something for address the issue, please tell me.
> Thanks
> Emilio Gargiulo

