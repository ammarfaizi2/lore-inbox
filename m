Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316898AbSH0TKP>; Tue, 27 Aug 2002 15:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316971AbSH0TKP>; Tue, 27 Aug 2002 15:10:15 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:65036 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316898AbSH0TKO>; Tue, 27 Aug 2002 15:10:14 -0400
Date: Tue, 27 Aug 2002 15:14:26 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200208271914.g7RJEQE07821@devserv.devel.redhat.com>
To: "chen, xiangping" <chen_xiangping@emc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is it possible to use 8K page size on a i386 pc?
In-Reply-To: <mailman.1030474690.4302.linux-kernel2news@redhat.com>
References: <mailman.1030474690.4302.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[...]
> I just wonder how PAGE_SIZE in determined in each architecture? Is it
> possible to use 8k or bigger page size in a i386 PC?
> 
> Thanks,
> Xiangping

You may run into trouble with something that calls mmap with
a fixed address, with executables which have text sizes of
odd number of small pages. I was told that these problems are
fairly rare.

Running a bigger page size does nothing to help your TLB
coverage, but it might improve paging performance (or
it might not).

-- Pete
