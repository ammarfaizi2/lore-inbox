Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317433AbSFHTn1>; Sat, 8 Jun 2002 15:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317434AbSFHTn0>; Sat, 8 Jun 2002 15:43:26 -0400
Received: from [203.117.131.12] ([203.117.131.12]:5826 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S317433AbSFHTn0>; Sat, 8 Jun 2002 15:43:26 -0400
Message-ID: <3D025E50.1020506@metaparadigm.com>
Date: Sun, 09 Jun 2002 03:43:12 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020531 Debian/1.0rc3-2
MIME-Version: 1.0
To: manjuanth n <manju_tt@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: need help
In-Reply-To: <20020608112710.23692.qmail@web14403.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.18 needs a hint added to drivers/scsi/scsi_scan.c
to allow it to scan targets with sparse luns.

Look in /proc/scsi/scsi for the vendor and model and
add them into the device_list array in scsi_scan.c

...
{"<VENDOR>", "<MODEL>", "*", BLIST_SPARSELUN},

If you don't configure lun 0, you may have to use
BLIST_FORCELUN which if my understanding is correct
will force scanning of all luns.

I hear there is some REPORT_LUNS code that will
eliminate the need to do this, although don't know
which kernel has it.

~mc

On 06/08/02 19:27, manjuanth n wrote:

>Dear sir,
> we have SAN environment  with hitachi  storage box
>and  brocade  switch. we are trying to  install Linux 
>with  qlogic  HBA card.  we  are facing strange 
>problems 
>1. If  we  disable LUN 0  we will not be able to see
>any LUNs on liunx  machine
>2. If we  enable  LUN 0  we can  see all the  LUNS 
>but  it  should be in sequence  i.e LUN0 ,1,2 , 3  etc
>if we disable  LUN 3  we will not be able  to see LUNS
>4 and  the  rest
> Is the  above things  are limitation of linux.
>Linux  machine is  running with  2.4.18 kernel
>
>Is there any solutions for  these problems? 
>
>Thanks and Regards
>Manjuanth
>
>
>__________________________________________________
>Do You Yahoo!?
>Yahoo! - Official partner of 2002 FIFA World Cup
>http://fifaworldcup.yahoo.com
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>


