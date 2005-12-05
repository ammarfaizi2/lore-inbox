Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbVLEXg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbVLEXg6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbVLEXg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:36:58 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:55272 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964787AbVLEXg5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:36:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rO+q+qMPp45RuvfGs/GzyUlRg4ssK7ramPQmfeY/vgtEts59pX3V/h5gX5/LMz31UOS4wEdlu2wdDWqWQLp/kfmN1Xvkl5ccF7bC2Z3pg4lDQ/mptQIa0IHfUo2V8o6Oh/G4gsYEau2pfcYIHU+j1DPUxLJfe+jPdPULzQT8YkM=
Message-ID: <58cb370e0512051536v78ea28a7q9ce71ac0cb2c4af2@mail.gmail.com>
Date: Tue, 6 Dec 2005 00:36:52 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: "Marco d'Itri" <md@linux.it>
Subject: Re: ide: MODALIAS support for autoloading of ide-cd, ide-disk, ...
Cc: Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
In-Reply-To: <58cb370e0512051518j35885be1j44f7846e2d27c63d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051203172418.GA12297@vrfy.org>
	 <58cb370e0512050024s647fdc5eg8d0c2e60dd7867dd@mail.gmail.com>
	 <20051205182856.GB8827@wonderland.linux.it>
	 <58cb370e0512051518j35885be1j44f7846e2d27c63d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And after more careful inspection....

$ tree /sys/bus/ide/devices/0.0/
/sys/bus/ide/devices/0.0/
|-- block -> ../../../../../block/hda
|-- bus -> ../../../../../bus/ide
|-- driver -> ../../../../../bus/ide/drivers/ide-disk
|-- power
|   |-- state
|   `-- wakeup
`-- uevent

this is with the standard kernel without this patch.

Key, could you please explain what this patch actually *does*
(besides adding MODALIAS support) to such sysfs dummy as me?

Thanks,
Bartlomiej

On 12/6/05, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> On 12/5/05, Marco d'Itri <md@linux.it> wrote:
> > On Dec 05, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> >
> > > Looks fine but what about ide-scsi driver and ide_optical media?
> > The Debian hotplug script, which does the same thing, does not know
> > about these modules and nobody ever complained, so if some support is
>
> Does the hotplug script export kernel sysfs attributes?
>
> > needed it can be added later.
>
> The problem is that you get wrong data for "modalias" sysfs attribute
> for ide-scsi module (because "modalias" is based on the media type).
>
> Until this is issue solved I can't accept this patch.
>
> > (And ide-scsi is dead anyway...)
>
> ide-scsi is the only way to support some devices currently
>
> Bartlomiej
>
