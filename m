Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318044AbSHVXIY>; Thu, 22 Aug 2002 19:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318059AbSHVXIY>; Thu, 22 Aug 2002 19:08:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30994 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318044AbSHVXIX>;
	Thu, 22 Aug 2002 19:08:23 -0400
Message-ID: <3D656FDC.8040008@mandrakesoft.com>
Date: Thu, 22 Aug 2002 19:12:28 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andre Hedrick <andre@linux-ide.org>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Padraig Brady'" <padraig.brady@corvil.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: IDE-flash device and hard disk on same controller
References: <Pine.LNX.4.10.10208201452210.3867-100000@master.linux-ide.org>	<3D62BC10.3060201@mandrakesoft.com>	<3D62C2A3.4070701@mandrakesoft.com> <m1sn17pici.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> I don't see any checking for the ATA bsy flag before you start sending
> commands.  I have seen the current IDE code fail too many times if I
> boot to fast, because of a lack of this one simple test.  So I don't
> see how this could be considered a proper probe.


There is no ATA bsy flag check at only one point, and that is before 
EXECUTE DEVICE DIAGNOSTIC is issued.  The idea with this command is that 
it pretty much stomps up and down the ATA bus, trouncing ongoing 
activity in the process.

	Jeff



