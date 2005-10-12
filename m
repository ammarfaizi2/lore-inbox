Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbVJLGV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbVJLGV0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 02:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVJLGV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 02:21:26 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:53765 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S1751128AbVJLGVZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 02:21:25 -0400
To: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/2] miss-sync changes on attributes (Re: [PATCH 2/2][FAT] miss-sync issues on sync mount (miss-sync on utime))
References: <43288A84.2090107@sm.sony.co.jp>
	<87oe6uwjy7.fsf@devron.myhome.or.jp> <433C25D9.9090602@sm.sony.co.jp>
	<20051011142608.6ff3ca58.akpm@osdl.org>
	<87r7armlgz.fsf@ibmpc.myhome.or.jp>
	<20051011211601.72a0f91c.akpm@osdl.org>
	<87psqbxreb.fsf@ibmpc.myhome.or.jp> <434CA527.90604@sm.sony.co.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 12 Oct 2005 15:21:12 +0900
In-Reply-To: <434CA527.90604@sm.sony.co.jp> (Hiroyuki Machida's message of "Wed, 12 Oct 2005 14:54:47 +0900")
Message-ID: <87r7arqmqv.fsf@ibmpc.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Machida, Hiroyuki" <machida@sm.sony.co.jp> writes:

> OGAWA Hirofumi wrote:
>> Andrew Morton <akpm@osdl.org> writes:
>> 
>>>However there's not much point in writing a brand-new function when
>>>write_inode_now() almost does the right thing.  We can share the
>>>implementation within fs-writeback.c.
>> Indeed. We use the generic_osync_inode() for it?
>
> Please let me confirm.
> Using generic_osync_inode(inode, NULL, OSYNC_INODE) instaed of
> sync_inode_wodata(inode) is peferable for changes on fs/open.c,
> even it would write data. Is it correct?

No, I only thought the interface is good. I don't know why it writes
data pages even if OSYNC_INODE only.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
