Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319188AbSHND5D>; Tue, 13 Aug 2002 23:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319191AbSHND5D>; Tue, 13 Aug 2002 23:57:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1297 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319186AbSHND5B>; Tue, 13 Aug 2002 23:57:01 -0400
Message-ID: <3D59D5E6.1010608@zytor.com>
Date: Tue, 13 Aug 2002 21:00:38 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] printk from userspace
References: <3D59CBFA.9CFC9FEE@zip.com.au> <20020813235803.A15947@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> On Tue, Aug 13, 2002 at 08:18:18PM -0700, Andrew Morton wrote:
> 
>>The patch allows userspace to issue printk's, via sys_syslog():
> 
> 
> This is an incredibly bad idea.  It has security hole written all over it.  
> Any user can now spam the kernel's log ringbuffer and overrun potentially 
> important messages.
> 

First of all, only CAP_SYS_ADMIN.  As far as spamming the ring buffer, 
that's trivial to do today by just sending a bunch of bad network 
packets, or attaching a USB CD-ROM without a disc in the drive (yes, 
really... on my wife's laptop it was so bad that unless she unplugged 
the CD-ROM syslogd was eating her system alive), or...

	-hpa


