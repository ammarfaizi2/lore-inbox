Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbTKDLw6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 06:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbTKDLw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 06:52:58 -0500
Received: from moof.zeroth.org ([203.117.131.35]:10502 "EHLO moof.zeroth.org")
	by vger.kernel.org with ESMTP id S261217AbTKDLw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 06:52:56 -0500
Message-ID: <3FA79308.3070300@metaparadigm.com>
Date: Tue, 04 Nov 2003 19:52:40 +0800
From: Jamie Clark <jamie@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031010 Debian/1.4-6
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23pre6aa3 scsi oops
References: <3FA713B9.3040405@metaparadigm.com> <20031104102816.GB2984@x30.random>
In-Reply-To: <20031104102816.GB2984@x30.random>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I made the quick fix (disabling rq_mergeable) and started the load test.
Will let it run for a week or so.

Thanks for the help!
-Jamie

FYI an observation from my last test: the read latency seems to be much
improved and more consistent under this kernel (2.4.23pre6aa3, before
the oops and before this fix).  The maximum latency seemed steady over
the whole test without any of the longish pauses that showed up under
2.4.19. Quite a difference.

Andrea Arcangeli wrote:

>On Tue, Nov 04, 2003 at 10:49:29AM +0800, Jamie Clark wrote:
>
>>Hi,
>>
>>Consistent oops with 2.4.23pre6aa3 after 3-4 hours running bonnie on 
>>ext3 fs through qla2300 HBA. (w SMP, HIGHMEM) The test machine was 
>>completely wedged so I ended up transcribing the oops from the vga 
>>console. No typos I think.
>>
>I need to release an update that has a chance to fix it. Jens identified
>problem in his last_merge scsi patch so I will back it out.
>
>you can try to backout it by yourself in the meantime, it's called
>\*elevator-merge-fast-path\* . or you can disable it with this patch:
>


