Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273390AbRINNqC>; Fri, 14 Sep 2001 09:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273389AbRINNpx>; Fri, 14 Sep 2001 09:45:53 -0400
Received: from dwdmx2.dwd.de ([141.38.2.10]:15113 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id <S273390AbRINNpt>;
	Fri, 14 Sep 2001 09:45:49 -0400
Date: Fri, 14 Sep 2001 15:46:10 +0200 (CEST)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
To: Frank Schneider <SPATZ1@t-online.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: AIC7xxx errors in 2.2.19 but not in 2.2.18
In-Reply-To: <3BA2021F.488F65F8@t-online.de>
Message-Id: <Pine.LNX.4.30.0109141523190.27057-100000@talentix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Fri, 14 Sep 2001, Frank Schneider wrote:

> Holger Kiehl schrieb:
> >
> > Hello
> >
> > I am getting SCSI errors with an onboard Adaptec AIC-7890/1 Ultra2, but
> > only under very heavy disk load and only under kernel 2.2.19. These errors
> > do not appear under 2.2.18.
> >
> > The system I have is a dual PIII-450 with 6 disks attached to the controller.
> > All disks are put together in SW-Raid5 array with one configured as hot
> > spare.
> >
>
> (..log snipped..)
>
> > >From Alan's changelog I see that there where changes in the AIC7xxx code.
> > Any idea what is wrong here?
>
> Hello...
>
> I (and someone else) had also mysterious problems with AIC7xxx and
> RAID1/5, but we use Kernel 2.4.x.
>
Just today Neil Brown has send a patch where he mentioned something
about the AIC7xxx driver. But I don't know if this has anything
to do with this problem.

> In Kernel 2.4.x you can choose between two versions of the
> aix7xxx-driver, one "old" one (Version 5.2.x) and a "new" one (Version
> 6.x.x). Do a "cat /proc/scsi/aic7xxx/0" to find your version.
>
I have played with 2.4.5 and the new aic7xxx driver and did not see
the problems here. Have not tried the old one under 2.4.5. Unfortunately
I cannot take 2.4.x because of the bigger swap demand.

> We both found out that our problems dissapear when we use the "old"
> driver (my tests are still in progress because my error (always the same
> scsi-disk falling out of an raid5-array with an "internal error", but
> the disk seems to be good) only appeared randomly about once a week, so
> i still have to wait if it is really gone.
>
> So perhaps you can try to use the older driver or determine the version
> of your aic7xxx-driver. Perhaps you can use the aic7xxx-driver from
> kernel 2.2.18 in Kernel 2.2.19 ?
>
> You should also boot your system with the parameter "aic7xxx=verbose",
> that will provide more infos in the syslog.
>
Next time when I boot, I will put in this option.

Thanks,
Holger

