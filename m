Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284794AbRLLAwH>; Tue, 11 Dec 2001 19:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284788AbRLLAv7>; Tue, 11 Dec 2001 19:51:59 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:46310
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S284794AbRLLAvz>; Tue, 11 Dec 2001 19:51:55 -0500
Date: Tue, 11 Dec 2001 19:47:39 -0500
From: Chris Mason <mason@suse.com>
To: Johan Ekenberg <johan@ekenberg.se>, linux-kernel@vger.kernel.org
Subject: Re: Lockups with 2.4.14 and 2.4.16
Message-ID: <2502410000.1008118058@tiny>
In-Reply-To: <000901c1829b$b38e1720$050010ac@FUTURE>
In-Reply-To: <000901c1829b$b38e1720$050010ac@FUTURE>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, December 12, 2001 12:29:38 AM +0100 Johan Ekenberg
<johan@ekenberg.se> wrote:

> We recently upgraded 10 servers from 2.2.19 to 2.4.14/2.4.16. Since then,
> several servers have experienced severe lockups forcing hardware resets. The
> machines are Intel PIII (Dual) SMP running Epox motherboards. Here are the
> details:
> 
>## Kernel:
>  - 2.4.14 and 2.4.16
>  - Patched for reiserfs-quota with patches found at
>    ftp://ftp.suse.com/pub/people/mason/patches/reiserfs/quota-2.4/
>      ( * 50_quota-patch
>        * dquota_deadlock
>        * nesting
>        * reiserfs-quota )

For the 2.4.16 kernel, you used the quota patches from my 2.4.16 dir?

>  - Complete kernel-config found here:
> http://www.ekenberg.se/2.4-trouble/2.4.16-config
>  - Boot parameters are: "ether=0,0,eth1 panic=60 noapic"
> 
>## Filesystems:
>  - ReiserFS (3.6) except /boot which is ext2
> 
>## General
>  - The servers are used mainly for:
>    * Apache/PHP with ~1000 VHosts
>    * Mail (Sendmail, imap, pop3)
>    * MySQL

Anyone know offhand if mysql uses mmap for writing to the database files?
The docs mention it for readonly compressed tables.

The fastest way to rule out filesystem deadlocks is to hook up a serial
console and send me the decoded output of sysrq-t.

-chris

