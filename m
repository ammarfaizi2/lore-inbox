Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264688AbTBACi2>; Fri, 31 Jan 2003 21:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264697AbTBACi2>; Fri, 31 Jan 2003 21:38:28 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:7816 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S264688AbTBACi1>; Fri, 31 Jan 2003 21:38:27 -0500
Message-ID: <3E3B351D.40208@blue-labs.org>
Date: Fri, 31 Jan 2003 18:46:53 -0800
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030125
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, neilb@cse.unsw.edu.au
Subject: Re: NFS problems, 2.5.5x
References: <3E3B2D2E.8000604@blue-labs.org> <20030131183059.1d37d01f.akpm@digeo.com>
In-Reply-To: <20030131183059.1d37d01f.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Underlying filesystems on both client and server are reiserfs.

Got any more quickie suggestions? :)

Thanks,
David

Andrew Morton wrote:

>David Ford <david+powerix@blue-labs.org> wrote:
>  
>
>>Synopsis:  nfsserver:/home/david mount, get dir. entries loops forever, 
>>2.5.59 for client and server.
>>    
>>
>
>If the server is ext3+htree then you've hit the htree dir cookie bug.
>
>Use `dumpe2fs -h /dev/hda1 | grep index' to se if you're using htree.
>
>Use `tune2fs -O ^dir_index /dev/hda1' to disable it.
>  
>

