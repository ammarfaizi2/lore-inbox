Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266590AbUBQWm1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 17:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266648AbUBQWm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 17:42:26 -0500
Received: from ms-smtp-03-qfe0.socal.rr.com ([66.75.162.135]:55269 "EHLO
	ms-smtp-03-eri0.socal.rr.com") by vger.kernel.org with ESMTP
	id S266590AbUBQWmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 17:42:12 -0500
Message-ID: <40329893.2080208@san.rr.com>
Date: Tue, 17 Feb 2004 14:41:23 -0800
From: Tom Guilliams <tguilliams@san.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040118
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: vda <vda@port.imtp.ilyichevsk.odessa.ua>, DHollenbeck <dick@softplc.com>,
       busybox@mail.codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: [BusyBox] [Fwd: Loopback device setup?]
References: <Pine.LNX.4.44.0402171649420.22275-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0402171649420.22275-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to all who responded.  I have a 2.4.20 kernel so mounting on the 
tmpfs is not supported.  I have found an alternative by using the ram 
device nodes for storage.

Thanks again,

Tom

Hugh Dickins wrote:
> On Tue, 17 Feb 2004, vda wrote:
> 
>>On Tuesday 17 February 2004 02:20, Tom Guilliams wrote:
>>
>>>in /driver/block/loop.c -
>>>
>>>loop_set_fd()
>>>
>>>		/*
>>>                  * If we can't read - sorry. If we only can't write -
>>>                 		 * well, it's going to be read-only.
>>>                  */
>>>                 if (!aops->readpage)
>>>                         goto out_putf;
>>>
>>>I confirmed the "if (!aops->readpage)" is true.  I'm not sure what the
>>>readpage routine is trying to do (which dev or file) in my command below -
>>># mount -t ext2 -o loop ramdisk.image rootfs
>>>
>>>Anyone have any thoughts??  This is all being done in the /tmp
>>>dircectory which is mounted as "tmpfs".  Not sure if that has anything
>>>to do with it.
>>
>>I recall that tmpfs cannot do readpage (by design?).
>>CCing LKML, maybe someone will pour in more info.
> 
> 
> readpage is not straightforward for tmpfs, so it took a long time
> to be added, but tmpfs has supported loop since 2.4.22 and 2.5.45.
> 
> Hugh
> 
> 
