Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271134AbTHLVMS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 17:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271148AbTHLVMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 17:12:00 -0400
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:63444
	"EHLO bastard") by vger.kernel.org with ESMTP id S271140AbTHLVKv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 17:10:51 -0400
Message-ID: <3F3957CB.70006@tupshin.com>
Date: Tue, 12 Aug 2003 14:10:35 -0700
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030723 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christophe Saout <christophe@saout.de>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: data corruption using raid0+lvm2+jfs with 2.6.0-test3
References: <3F3951F1.9040605@tupshin.com> <1060722538.8344.11.camel@chtephan.cs.pocnet.net>
In-Reply-To: <1060722538.8344.11.camel@chtephan.cs.pocnet.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout wrote:

>Am Di, 2003-08-12 um 22.45 schrieb Tupshin Harper:
>
>  
>
>>I have an LVM2 setup with four lvm groups. One of those groups sits on 
>>top of a two disk raid 0 array. When writing to JFS partitions on that 
>>lvm group, I get frequent, reproducible data corruption. This same setup 
>>works fine with 2.4.22-pre kernels. The JFS may or may not be relevant, 
>>since I haven't had a chance to use other filesystems as a control. 
>>There are a number of instances of the following message associated with 
>>the data corruption:
>>
>>raid0_make_request bug: can't convert block across chunks or bigger than 
>>8k 12436792 8
>>
>>The 12436792 varies widely, the rest is always the same. The error is 
>>coming from drivers/md/raid0.c.
>>    
>>
>
>Why don't you try using an LVM2 stripe? That's the same as raid0 does.
>And I'm sure it doesn't suffer from such problems because it's handling
>bios in a very generic and flexible manner.
>
Yes, I'm already converting to such a setup as I type this. I thought 
that a data corruption issue was worth mentioning, however. ;-)

-Tupshin

