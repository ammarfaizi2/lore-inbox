Return-Path: <linux-kernel-owner+w=401wt.eu-S1161119AbXALWBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161119AbXALWBz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 17:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161120AbXALWBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 17:01:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44019 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161116AbXALWBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 17:01:53 -0500
Message-ID: <45A80544.2030803@redhat.com>
Date: Fri, 12 Jan 2007 16:01:40 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext4 development <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] [RFC] remove ext3 inode from orphan list when link and
 unlink race
References: <45A7F384.3050303@redhat.com> <m34pqw0xii.fsf@bzzz.home.net>	<45A7FA3C.8030209@redhat.com> <m3lkk8ym2f.fsf@bzzz.home.net>	<45A80213.5060401@redhat.com> <m3hcuvzz88.fsf@bzzz.home.net>
In-Reply-To: <m3hcuvzz88.fsf@bzzz.home.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
>>>>>> Eric Sandeen (ES) writes:
>  ES> I tend to agree, chatting w/ Al I think he does too.  :)  I'll test
>  ES> a patch that kicks out ext3_link() with -ENOENT at the top, and resubmit
>  ES> that if things go well.
> 
> shouldn't VFS do that?

Al says "no" and I'm not arguing.  :)

Apparently this may be OK with some filesystems, and Al says he doesn't
want to know about i_nlink in the vfs in any case.

But I suppose there may be other filesystems which DO care, and should
be checking if they're not.

-Eric
