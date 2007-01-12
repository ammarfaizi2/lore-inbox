Return-Path: <linux-kernel-owner+w=401wt.eu-S1161102AbXALVsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161102AbXALVsV (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 16:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161099AbXALVsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 16:48:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40381 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161098AbXALVsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 16:48:20 -0500
Message-ID: <45A80213.5060401@redhat.com>
Date: Fri, 12 Jan 2007 15:48:03 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext4 development <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] [RFC] remove ext3 inode from orphan list when link and
 unlink race
References: <45A7F384.3050303@redhat.com> <m34pqw0xii.fsf@bzzz.home.net>	<45A7FA3C.8030209@redhat.com> <m3lkk8ym2f.fsf@bzzz.home.net>
In-Reply-To: <m3lkk8ym2f.fsf@bzzz.home.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
>>>>>> Eric Sandeen (ES) writes:
> 
>  ES> so I think it's possible that link can sneak in there & find it after
>  ES> the mutex is dropped...?  Is this ok? :)  It's certainly -happening-
>  ES> anyway....
> 
> yes, but it shouldn't allow to re-link such inode back, IMHO.
> a filesystem may start some non-revertable activity in its
> unlink method.
> 
> thanks, Alex

I tend to agree, chatting w/ Al I think he does too.  :)  I'll test
a patch that kicks out ext3_link() with -ENOENT at the top, and resubmit
that if things go well.

-Eric
