Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135284AbRDRUQr>; Wed, 18 Apr 2001 16:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135288AbRDRUQg>; Wed, 18 Apr 2001 16:16:36 -0400
Received: from 207.111.252.195.got.net ([207.111.252.195]:27145 "EHLO
	rapid-money.net") by vger.kernel.org with ESMTP id <S135284AbRDRUQV>;
	Wed, 18 Apr 2001 16:16:21 -0400
Message-ID: <3ADDF60F.E3C0869B@rapidmoney.com>
Date: Wed, 18 Apr 2001 13:16:15 -0700
From: Kate Rosenbloom <kate-nospam@rapidmoney.com>
Organization: RapidMoney
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: frank.gevaerts@fks.be
Subject: Dell PowerVault 100T DDS4 tape on RedHat
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was able to use this tape drive on RedHat 6.2 after updating the 
drive firmware, using an update package from Dell:
 
http://support.dell.com/us/en/filelib/download/index.asp?fileid=R25138&sid

I considered updating to a later Adaptec driver (aic7xxx 5.1.33), later
kernel
(2.2.16 or later), or RH7.1, but the firmware update (to 8130) did the
trick for me.  Attached is another poster's description of the problem,
and his solution...

        Kate Rosenbloom
        RapidMoney Corp.
        Santa Cruz, CA
---------------------------------------------------------------------------------------
        On Mon, 16 Apr 2001, Kate Rosenbloom wrote:

> Hello Frank,
>
> While trying to setup a backup system with our Dell linux box, I ran
> into problems.
> A web search turned up your September posting to linux-kernel.  This
> describes our problem too. Did you ever solve it ?

Yes. Our problem was solved by upgrading the kernel to 2.2.16. We had
2.2.14 previously, which apparently has some problems.

> -----------------------------------------------------------------------------------
>
> We are trying to use a Dell poweredge 1300 with a dds4 tape drive
> When we try reading from a tape, the reading process gets stuck in D
> state
> after the last data has been read. According to ps l, the process is
> stuck
> in down_failed. Turning hardware compression on and off, or switching to
> a
> DDS2 tape does not solve the problem.
>
> This is the tape drive (AKA Dell PowerVault 100T DDS4 Drive)
> Host: scsi0 Channel: 00 Id: 06 Lun:
> 00
>   Vendor: ARCHIVE Model: Python 06408-XXX Rev: 8071
>   Type: Sequential-Access ANSI SCSI revision: 03
>
> The SCSI card is an adaptec :
>            SCSI Adapter: Adaptec AHA-294X Ultra2 SCSI host adapter
>                            Ultra-2 LVD/SE Wide Controller at PCI 0/13/0
>
> The system is running stock RedHat 6.2
> 2.2.14-6.1.1smp (the problem also occurs with an up kernel, we still
> have
> to switch the default boot).
>
> Is there anything we can try ?
>
> Thanks in advance,
>
> Frank Gevaerts
> Formal and Knowledge Systems
> Luikersteenweg 65
> B-3500 Hasselt
> Belgium
>


 Subject: 
           Re: Did you solve your tape drive problem ?
    Date: 
           Tue, 17 Apr 2001 09:53:17 +0200 (CEST)
   From: 
           frank.gevaerts@fks.be
       To: 
           Kate Rosenbloom <kate@rapidmoney.com>



On Mon, 16 Apr 2001, Kate Rosenbloom wrote:

> Hello Frank,
>
> While trying to setup a backup system with our Dell linux box, I ran
> into problems.
> A web search turned up your September posting to linux-kernel.  This
> describes our problem too. Did you ever solve it ?

Yes. Our problem was solved by upgrading the kernel to 2.2.16. We had
2.2.14 previously, which apparently has some problems.

Frank

>
>       Thanks in advance,
>
>               Kate Rosenbloom
>               RapidMoney Corp.
>               Santa Cruz, California
>
> -----------------------------------------------------------------------------------
>
> We are trying to use a Dell poweredge 1300 with a dds4 tape drive
> When we try reading from a tape, the reading process gets stuck in D
> state
> after the last data has been read. According to ps l, the process is
> stuck
> in down_failed. Turning hardware compression on and off, or switching to
> a
> DDS2 tape does not solve the problem.
>
> This is the tape drive (AKA Dell PowerVault 100T DDS4 Drive)
> Host: scsi0 Channel: 00 Id: 06 Lun:
> 00
>   Vendor: ARCHIVE Model: Python 06408-XXX Rev: 8071
>   Type: Sequential-Access ANSI SCSI revision: 03
>
> The SCSI card is an adaptec :
>            SCSI Adapter: Adaptec AHA-294X Ultra2 SCSI host adapter
>                            Ultra-2 LVD/SE Wide Controller at PCI 0/13/0
>
> The system is running stock RedHat 6.2
> 2.2.14-6.1.1smp (the problem also occurs with an up kernel, we still
> have
> to switch the default boot).
>
> Is there anything we can try ?
>
> Thanks in advance,
>
> Frank Gevaerts
> Formal and Knowledge Systems
> Luikersteenweg 65
> B-3500 Hasselt
> Belgium
>

--
Frank Gevaerts                                 frank.gevaerts@fks.be
fks bvba - Formal and Knowledge Systems        http://www.fks.be/
Luikersteenweg 65                              Tel:  ++32-(0)11-21 49 11
B-3500 HASSELT                                 Fax:  ++32-(0)11-22 04 19
