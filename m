Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273385AbRINNNb>; Fri, 14 Sep 2001 09:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273380AbRINNNW>; Fri, 14 Sep 2001 09:13:22 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:55302 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S273385AbRINNNB>; Fri, 14 Sep 2001 09:13:01 -0400
Message-ID: <3BA2021F.488F65F8@t-online.de>
Date: Fri, 14 Sep 2001 15:11:59 +0200
From: SPATZ1@t-online.de (Frank Schneider)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3-test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Holger Kiehl <Holger.Kiehl@dwd.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: AIC7xxx errors in 2.2.19 but not in 2.2.18
In-Reply-To: <Pine.LNX.4.30.0109141121010.27057-100000@talentix.dwd.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holger Kiehl schrieb:
> 
> Hello
> 
> I am getting SCSI errors with an onboard Adaptec AIC-7890/1 Ultra2, but
> only under very heavy disk load and only under kernel 2.2.19. These errors
> do not appear under 2.2.18.
> 
> The system I have is a dual PIII-450 with 6 disks attached to the controller.
> All disks are put together in SW-Raid5 array with one configured as hot
> spare.
> 

(..log snipped..)
 
> >From Alan's changelog I see that there where changes in the AIC7xxx code.
> Any idea what is wrong here?

Hello...

I (and someone else) had also mysterious problems with AIC7xxx and
RAID1/5, but we use Kernel 2.4.x.

In Kernel 2.4.x you can choose between two versions of the
aix7xxx-driver, one "old" one (Version 5.2.x) and a "new" one (Version
6.x.x). Do a "cat /proc/scsi/aic7xxx/0" to find your version.

We both found out that our problems dissapear when we use the "old"
driver (my tests are still in progress because my error (always the same
scsi-disk falling out of an raid5-array with an "internal error", but
the disk seems to be good) only appeared randomly about once a week, so
i still have to wait if it is really gone.

So perhaps you can try to use the older driver or determine the version
of your aic7xxx-driver. Perhaps you can use the aic7xxx-driver from
kernel 2.2.18 in Kernel 2.2.19 ?

You should also boot your system with the parameter "aic7xxx=verbose",
that will provide more infos in the syslog.

Solong..
Frank.

--
Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
Microsoft isn't the answer.
Microsoft is the question, and the answer is NO.
... -.-
