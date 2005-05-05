Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbVEEMNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbVEEMNZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 08:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbVEEMNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 08:13:25 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:23760 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262049AbVEEMNV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 08:13:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DipTB/iwzr9yTwMg/WB4EFGUAdagsYzYzYpI/FK83h+/vhx4S1mWRPVWh68qxu63ah/C03KhfEZaY90ZwoIzvGrW3uCb48byU9MY6eGXJDQWMZq7LQcxa68/oQg/M8uny5OuChg/kWkh/7Eu19EMTkvihg+PbsPuABVn+cEpQIc=
Message-ID: <58cb370e050505051360d0588c@mail.gmail.com>
Date: Thu, 5 May 2005 14:13:20 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/ide/hd?/settings obsolete in 2.6.
In-Reply-To: <20050505111324.GA17223@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050505004854.GA16550@animx.eu.org>
	 <58cb370e050505031041c2c164@mail.gmail.com>
	 <20050505111324.GA17223@animx.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/5/05, Wakko Warner <wakko@animx.eu.org> wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On 5/5/05, Wakko Warner <wakko@animx.eu.org> wrote:
> > > If this interface is obsolete and will be removed, is there any non-obsolete
> > > way of telling the kernel what geometry I want to use for this ide device?
> >
> > Yes, physical geometry - through boot parameters and logical geometry
> > is not needed for IDE layer to function properly.
> 
> I did not ask if it was needed for it to function, I asked how to set it
> since the "settings" file is obsolete.  Yes, I do need to set this.  I want
> to know what the "non-obsolete" way is.  A project I'm working on uses linux
> to do something with the drive and that is dependant on the geometry that
> linux provides to programs be the same as what the bios thinks.  I know how
> to obtain the bios values.  I have to set these values to the kernel so
> everything functions properly.
> 
> If there is no "non-obsolete" way of doing this, then fine, I'll continue
> with the settings thing.

Please be aware that new applications are expected to use
/sys/firmware/edd/default_* instead of legacy HDIO_GETGEO ioctl
and there is currently no way to set these sysfs entries (maybe it
would be worthwile to add such functionality?).

Thanks,
Bartlomiej
