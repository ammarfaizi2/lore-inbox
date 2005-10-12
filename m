Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbVJLF46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbVJLF46 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 01:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbVJLF46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 01:56:58 -0400
Received: from NS8.Sony.CO.JP ([137.153.0.33]:57483 "EHLO ns8.sony.co.jp")
	by vger.kernel.org with ESMTP id S932355AbVJLF46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 01:56:58 -0400
Message-ID: <434CA527.90604@sm.sony.co.jp>
Date: Wed, 12 Oct 2005 14:54:47 +0900
From: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/2] miss-sync changes on attributes (Re: [PATCH 2/2][FAT]
 miss-sync issues on sync mount (miss-sync on utime))
References: <43288A84.2090107@sm.sony.co.jp>	<87oe6uwjy7.fsf@devron.myhome.or.jp> <433C25D9.9090602@sm.sony.co.jp>	<20051011142608.6ff3ca58.akpm@osdl.org>	<87r7armlgz.fsf@ibmpc.myhome.or.jp>	<20051011211601.72a0f91c.akpm@osdl.org> <87psqbxreb.fsf@ibmpc.myhome.or.jp>
In-Reply-To: <87psqbxreb.fsf@ibmpc.myhome.or.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



OGAWA Hirofumi wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> 
>>However there's not much point in writing a brand-new function when
>>write_inode_now() almost does the right thing.  We can share the
>>implementation within fs-writeback.c.
> 
> 
> Indeed. We use the generic_osync_inode() for it?

Please let me confirm.
Using generic_osync_inode(inode, NULL, OSYNC_INODE) instaed of
sync_inode_wodata(inode) is peferable for changes on fs/open.c,
even it would write data. Is it correct?


-- 
Hiroyuki Machida		machida@sm.sony.co.jp		

