Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318735AbSHWKIc>; Fri, 23 Aug 2002 06:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318738AbSHWKIb>; Fri, 23 Aug 2002 06:08:31 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:2807 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318735AbSHWKIb>; Fri, 23 Aug 2002 06:08:31 -0400
Subject: Re: IDE-flash device and hard disk on same controller
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andre Hedrick <andre@linux-ide.org>,
       "Heater, Daniel (IndSys, " "GEFanuc, VMIC)" 
	<Daniel.Heater@gefanuc.com>,
       "'Padraig Brady'" <padraig.brady@corvil.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
In-Reply-To: <20020823114157.29703@192.168.4.1>
References: <3D658F2C.1080400@mandrakesoft.com> 
	<20020823114157.29703@192.168.4.1>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 23 Aug 2002 11:12:29 +0100
Message-Id: <1030097549.5932.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-23 at 12:41, Benjamin Herrenschmidt wrote:
> Also, another issue we didn't deal with properly yet is PM. With non-APM
> power management (like pmac, but probably also ACPI and some embedded
> devices), the devices will be basically powered off during suspend, and
> no firmware is here to put them back into life on wakeup. So you have to
> redo the bringup, which, in some cases (like hotswap IDE bays on some
> PowerBooks) probably involves re-running the probe procedure at least,

ACPI deals with this itself. The problem however can occur in other
cases (hot plug ATA disks for one).

