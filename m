Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316259AbSEQPVP>; Fri, 17 May 2002 11:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316260AbSEQPVP>; Fri, 17 May 2002 11:21:15 -0400
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:9719 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S316259AbSEQPVN>; Fri, 17 May 2002 11:21:13 -0400
Date: Fri, 17 May 2002 11:20:14 -0400 (EDT)
From: David G Hamblen <dave@AFRInc.com>
Reply-To: dave@AFRInc.com
To: John Ruttenberg <rutt@chezrutt.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Dell Inspiron i8100 with 2 batteries
In-Reply-To: <15589.5673.460356.221529@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0205171113550.1002-100000@puppy.afrinc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've got the same laptop with one battery, but I'm using ACPI. None of the
current user-space utilities parse this stuff particularly well (the
filenames in /proc/acpi have changed), but the data all look reasonable.

#cat /proc/acpi/battery/BAT1/*
alarm:                   3000 mWh
present:                 yes
design capacity:         57420 mWh
last full capacity:      57420 mWh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 3000 mWh
design capacity low:     1000 mWh
capacity granularity 1:  200 mWh
capacity granularity 2:  200 mWh
model number:            LIP8084DLP
serial number:           40086
battery type:            LION
OEM info:                Sony Corp.
present:                 yes
capacity state:          ok
charging state:          charging
present rate:            unknown
remaining capacity:      56670 mWh
present voltage:         16746 mV

Dave

On Fri, 17 May 2002, John Ruttenberg wrote:

> I thought I'd try to figure out that there were two batteries and divide by 2
> or something like that.  Perhaps the bios of this notebook is just broken,
> though.
> 
> Alan Cox:
> > > of the batteries is less than 50% (according to the bios), then /proc/apm
> > > shows the battery power level X 2.  If the combined charge of the batteries is
> > > greater than 50%, then /proc/apm shows:
> > > 
> > >     1.16 1.2 0x03 0x01 0xff 0x10 -1% -1 ?
> > > 
> > > I think this is because the bogus calculation it would make would result in a
> > > percentage > 100.
> > > 
> > > I took a quick look at arch/i386/kernel/apm.c but it wasn't obvious what to
> > > do.
> > 
> > The data basically comes from the BIOS as is
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

