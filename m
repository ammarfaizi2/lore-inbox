Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbUE1JiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbUE1JiA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 05:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbUE1JiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 05:38:00 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:44748 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266022AbUE1Jgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 05:36:51 -0400
Date: Fri, 28 May 2004 18:38:04 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
In-reply-to: <20040527135134.GC15356@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <2EC4449779759Findou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <20040527135134.GC15356@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2004 14:51:34 +0100, Christoph Hellwig wrote:

>> +/******************************** Disk dump ****************************
>> *******/
>> +#if defined(CONFIG_DISKDUMP) || defined(CONFIG_DISKDUMP_MODULE)
>> +#undef  add_timer
>> +#define add_timer       diskdump_add_timer
>> +#undef  del_timer_sync
>> +#define del_timer_sync  diskdump_del_timer
>> +#undef  del_timer
>> +#define del_timer       diskdump_del_timer
>> +#undef  mod_timer
>> +#define mod_timer       diskdump_mod_timer
>> +
>> +#define tasklet_schedule        diskdump_tasklet_schedule
>> +#endif
>
>Yikes.  No way in hell we'll place code like this in drivers.  This needs
>to be handled in common code.

Another method is to add codes for diskdump into add_timer/del_timer/etc
itself,  but I don't think it is good method. Do you have any good idea?

Best Regards,
Takao Indoh

