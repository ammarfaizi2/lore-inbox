Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264679AbSLWMHm>; Mon, 23 Dec 2002 07:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264711AbSLWMHm>; Mon, 23 Dec 2002 07:07:42 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:55347 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id <S264679AbSLWMHl>; Mon, 23 Dec 2002 07:07:41 -0500
Date: Mon, 23 Dec 2002 13:15:42 +0100
Subject: Re: Read this and be ashamed ;) or: Awfull performance loss since 2.4.18 to 2.4.21-pre2
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v548)
Cc: linux-kernel@vger.kernel.org
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
In-Reply-To: <200212221439.28075.m.c.p@wolk-project.de>
Message-Id: <41E779BC-1670-11D7-A27C-000393950CC2@karlsbakk.net>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.548)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

What disk/controller is this?

On Sunday, December 22, 2002, at 02:47 PM, Marc-Christian Petersen 
wrote:

> Hi all,
>
> not much to say about, just read. All are vanilla kernels w/o any 
> patch.
>
> /dev/hda5 on /home type ext3 (rw,data=ordered)
> /dev/hda5             10080488    731488   8836932   8% /home
>
> UDMA100 IDE Drive, DMA is on. All these runs were done right after 
> bootup.
> Mashine is a Celeron 1,3GHz, 512MB RAM, 512MB SWAP.
>
> root@codeman:[/] # uname -r
> 2.4.18
> root@codeman:[/] # dd if=/dev/zero of=/home/largefile bs=16384 
> count=131072
> 131072+0 records in
> 131072+0 records out
> 2147483648 bytes transferred in 119.140681 seconds (18024772 bytes/sec)
> root@codeman:[/] #
>
> root@codeman:[/] # uname -r
> 2.4.19
> root@codeman:[/] # dd if=/dev/zero of=/home/largefile bs=16384 
> count=131072
> 131072+0 records in
> 131072+0 records out
> 2147483648 bytes transferred in 140.305836 seconds (15305733 bytes/sec)
>
> root@codeman:[/] # uname -r
> 2.4.20
> root@codeman:[/] # dd if=/dev/zero of=/home/largefile bs=16384 
> count=131072
> 131072+0 records in
> 131072+0 records out
> 2147483648 bytes transferred in 172.327570 seconds (12461637 bytes/sec)
>
> root@codeman:[/] # uname -r
> 2.4.21-pre2
> root@codeman:[/] # dd if=/dev/zero of=/home/largefile bs=16384 
> count=131072
> 131072+0 records in
> 131072+0 records out
> 2147483648 bytes transferred in 177.743959 seconds (12081894 bytes/sec)
>
>
> ciao, Marc
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

