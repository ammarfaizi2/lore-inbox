Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316000AbSENTLD>; Tue, 14 May 2002 15:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316001AbSENTLC>; Tue, 14 May 2002 15:11:02 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:62638 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316000AbSENTLB>;
	Tue, 14 May 2002 15:11:01 -0400
Date: Tue, 14 May 2002 15:11:01 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
cc: Elladan <elladan@eskimo.com>, Christoph Hellwig <hch@infradead.org>,
        Elladan <elladan@eskimo.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
In-Reply-To: <200205141753.MAA70930@tomcat.admin.navo.hpc.mil>
Message-ID: <Pine.GSO.4.21.0205141505270.4648-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 May 2002, Jesse Pollard wrote:

> If the root file system is ext2, it does become a security issue since
> currently active logs will continue to record log entries until the

You are kidding.  First of all, what kind of idiot has /var on root?  What
next - /var/spool/mail on the same filesystem, so that mailbombing root
(or just a mail loop) could screw you over?

What's more, if you can't deal with overflowing /var/log, you are screwed -
making syslogd to write something in log is _not_ hard.

