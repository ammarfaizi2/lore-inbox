Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264049AbUDQUXw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 16:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264056AbUDQUXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 16:23:52 -0400
Received: from hera.kernel.org ([63.209.29.2]:17825 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S264049AbUDQUXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 16:23:39 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: msync() needed before munmap() when writing to shared mapping?
Date: Sat, 17 Apr 2004 20:23:21 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c5s3np$6ct$1@terminus.zytor.com>
References: <20040416220223.GA27084@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1082233401 6558 63.209.29.3 (17 Apr 2004 20:23:21 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sat, 17 Apr 2004 20:23:21 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040416220223.GA27084@mail.shareable.org>
By author:    Jamie Lokier <jamie@shareable.org>
In newsgroup: linux.dev.kernel
> 
> > munmap() and fsync() or msync() will flush it to disk; there is no
> > reason munmap() should unless perhaps the file was opened O_SYNC.
> 
> That was talking about flushing data all the way to disk.  The
> implication of hpa's response is that munmap() does propagate the
> dirty bits from the page table to the file.  That is the obvious
> behaviour, and what I've always assumed.
> 

Obvious behaviour, and required by POSIX.

	-hpa
