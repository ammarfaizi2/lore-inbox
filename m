Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319304AbSHVFoB>; Thu, 22 Aug 2002 01:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319307AbSHVFoB>; Thu, 22 Aug 2002 01:44:01 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:635 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S319304AbSHVFoA>; Thu, 22 Aug 2002 01:44:00 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Andre Hedrick <andre@linux-ide.org>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Padraig Brady'" <padraig.brady@corvil.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: IDE-flash device and hard disk on same controller
References: <Pine.LNX.4.10.10208201452210.3867-100000@master.linux-ide.org>
	<3D62BC10.3060201@mandrakesoft.com>
	<3D62C2A3.4070701@mandrakesoft.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Aug 2002 23:34:21 -0600
In-Reply-To: <3D62C2A3.4070701@mandrakesoft.com>
Message-ID: <m1sn17pici.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

> Jeff Garzik wrote:
> > Attached is the ATA core...
> 
> Just to give a little bit more information about the previously attached code,
> it is merely a module that does two things:  (a) demonstrates proper [and
> sometimes faster-than-current-linus] ATA bus probing, and 

I am assuming ata_chan_init is the function that does this
demonstration.

I don't see any checking for the ATA bsy flag before you start sending
commands.  I have seen the current IDE code fail too many times if I
boot to fast, because of a lack of this one simple test.  So I don't
see how this could be considered a proper probe.

Eric
