Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266997AbSKLWyt>; Tue, 12 Nov 2002 17:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266998AbSKLWyt>; Tue, 12 Nov 2002 17:54:49 -0500
Received: from jstevenson.plus.com ([212.159.71.212]:64684 "EHLO
	alpha.stev.org") by vger.kernel.org with ESMTP id <S266997AbSKLWyq>;
	Tue, 12 Nov 2002 17:54:46 -0500
Subject: Re: iostats broken for devices with major number > DK_MAX_DISK (16)
From: James Stevenson <james@stev.org>
To: Per Andreas Buer <perbu@linpro.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <PERBUMSGID-ul64ramh6g5.fsf@nfsd.linpro.no>
References: <PERBUMSGID-ul64ramh6g5.fsf@nfsd.linpro.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Nov 2002 23:01:03 +0000
Message-Id: <1037142064.1570.0.camel@god.stev.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-12 at 20:35, Per Andreas Buer wrote:
> Hi,
> 
> sorry for the intrusion. I noticed iostats didn't display statistics for
> devices on Mylex RAID constrollers. Det statistics are completely
> missing in /proc/stat. The reason seems to be an assumption that disks
> have major numbers which are below 16
> (http://lxr.linux.no/source/include/linux/kernel_stat.h#L15) which is
> used by http://lxr.linux.no/source/fs/proc/proc_misc.c#L344.
> 
> Devices on Mylex-controllers have major number 48. Would it break
> anything if DK_MAX_MAJOR if set higher (e.g. 64)?
> 
> AFAIK this goes for both 2.4 and the 2.5 series.

i have been runing with 2.4.x kernel with this number
set higher i have still yet to see any problem with it
other than using more memory.


