Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317488AbSHWJix>; Fri, 23 Aug 2002 05:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318109AbSHWJix>; Fri, 23 Aug 2002 05:38:53 -0400
Received: from [217.167.51.129] ([217.167.51.129]:33534 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S317488AbSHWJiw>;
	Fri, 23 Aug 2002 05:38:52 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andre Hedrick <andre@linux-ide.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Padraig Brady'" <padraig.brady@corvil.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: IDE-flash device and hard disk on same controller
Date: Fri, 23 Aug 2002 13:44:33 +0200
Message-Id: <20020823114433.10784@192.168.4.1>
In-Reply-To: <Pine.LNX.4.10.10208222014450.13077-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10208222014450.13077-100000@master.linux-ide.org>
X-Mailer: CTM PowerMail 3.1.2 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The problem is that immediately after bootup ATA devices do not respond
>until
>> their media has spun up.  Which is both required by the spec, and
>observed in
>> practice.   Which is likely a problem if this code is run a few seconds
>after
>> bootup.  Which makes it quite possible the drive will ignore the
>EXECUTE DEVICE
>> DIAGNOSTICS and your error code won't be valid when the bsy flag
>> clears.   I don't know how serious that would be. 
>
>We did POST already.

Well... x86 PCs with ordinary BIOSes did. Other firmwares,
embedded devices, whatever.... may not, or eventually the firmware
will have reset everything prior to booting the kernel (go figure
why, but that happens).

It's not difficult nor harmful to wait for that dawn busy bit to
go away, so why not do it ?

Ben.


