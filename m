Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbTJTRNH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 13:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbTJTRNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 13:13:07 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:10628 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S262666AbTJTRNE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 13:13:04 -0400
Message-ID: <3F9415D2.7030900@rackable.com>
Date: Mon, 20 Oct 2003 10:05:22 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Atul.Mukker@lsil.com
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pre7 Megaraid2 compile fails
References: <3F9414C5.1060003@rackable.com>
In-Reply-To: <3F9414C5.1060003@rackable.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Oct 2003 17:13:03.0634 (UTC) FILETIME=[6BEA3720:01C3972D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Flory wrote:
>   I'm not sure if anyone has reported this.
> 
> gcc -D__KERNEL__ -I/stuff/src/linux-2.4.23-pre7/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
> -nostdinc -iwithprefix include -DKBUILD_BASENAME=megaraid2  -c -o 
> megaraid2.o megaraid2.c
> megaraid2.c: In function `mega_find_card':
> megaraid2.c:403: structure has no member named `lock'
> make[3]: *** [megaraid2.o] Error 1
> make[3]: Leaving directory `/stuff/src/linux-2.4.23-pre7/drivers/scsi'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/stuff/src/linux-2.4.23-pre7/drivers/scsi'
> make[1]: *** [_subdir_scsi] Error 2
> make[1]: Leaving directory `/stuff/src/linux-2.4.23-pre7/drivers'
> make: *** [_dir_drivers] Error 2
> 
> 
>   The driver does compile as a module, but not built into the kernel.
> 
> 

   Actually it fails as module as well;-(  Sorry I could swear I saw it 
get past megaraid2.


-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

