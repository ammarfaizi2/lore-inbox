Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbVJLKHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbVJLKHG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 06:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbVJLKHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 06:07:06 -0400
Received: from NS8.Sony.CO.JP ([137.153.0.33]:60802 "EHLO ns8.sony.co.jp")
	by vger.kernel.org with ESMTP id S1751378AbVJLKHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 06:07:04 -0400
Message-ID: <434CD1A2.1090008@sm.sony.co.jp>
Date: Wed, 12 Oct 2005 18:04:34 +0900
From: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Subject: Re: [PATCH 1/2] miss-sync changes on attributes (Re: [PATCH 2/2][FAT]
 miss-sync issues on sync mount (miss-sync on utime))
References: <43288A84.2090107@sm.sony.co.jp>	<87oe6uwjy7.fsf@devron.myhome.or.jp>	<433C25D9.9090602@sm.sony.co.jp>	<20051011142608.6ff3ca58.akpm@osdl.org>	<87r7armlgz.fsf@ibmpc.myhome.or.jp>	<20051011211601.72a0f91c.akpm@osdl.org>	<87psqbxreb.fsf@ibmpc.myhome.or.jp>	<434CA527.90604@sm.sony.co.jp> <20051011231015.6a1c4c5b.akpm@osdl.org>
In-Reply-To: <20051011231015.6a1c4c5b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:
> "Machida, Hiroyuki" <machida@sm.sony.co.jp> wrote:
> 
>>
>>
>>OGAWA Hirofumi wrote:
>>
>>>Andrew Morton <akpm@osdl.org> writes:
>>>
>>>
>>>
>>>>However there's not much point in writing a brand-new function when
>>>>write_inode_now() almost does the right thing.  We can share the
>>>>implementation within fs-writeback.c.
>>>
>>>
>>>Indeed. We use the generic_osync_inode() for it?
>>
>>Please let me confirm.
>>Using generic_osync_inode(inode, NULL, OSYNC_INODE) instaed of
>>sync_inode_wodata(inode) is peferable for changes on fs/open.c,
>>even it would write data. Is it correct?
>>
> 
> 
> I don't know.  It depends on what you're actually trying to do, and I don't
> recall anyone having described that!

I'm just little confused, because I realized generic_osync_inode(,,OSYNC_INODE)
calls sync_inode_now(), however Ogawasa-san pointed out sync_inode_now() which
my first patch used is writing data page.


-- 
Hiroyuki Machida		machida@sm.sony.co.jp		
SSW Dept. HENC, Sony Corp.

