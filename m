Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030536AbVKDAPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030536AbVKDAPd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030559AbVKDAPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:15:33 -0500
Received: from www.eclis.ch ([144.85.15.72]:22725 "EHLO mail.eclis.ch")
	by vger.kernel.org with ESMTP id S1030536AbVKDAPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:15:32 -0500
Message-ID: <436AA822.9060403@eclis.ch>
Date: Fri, 04 Nov 2005 01:15:30 +0100
From: Jean-Christian de Rivaz <jc@eclis.ch>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
Cc: rddunlap@osdl.org, Len Brown <len.brown@intel.com>, macro@linux-mips.org,
       linux-kernel@vger.kernel.org, dean@arctic.org, zippel@linux-m68k.org
Subject: Re: NTP broken with 2.6.14
References: <4369464B.6040707@eclis.ch>	 <1130973717.27168.504.camel@cog.beaverton.ibm.com>	 <43694DD1.3020908@eclis.ch>	 <1130976935.27168.512.camel@cog.beaverton.ibm.com>	 <43695D94.10901@eclis.ch>	 <1130980031.27168.527.camel@cog.beaverton.ibm.com>	 <43697550.7030400@eclis.ch>	 <1131046348.27168.537.camel@cog.beaverton.ibm.com>	 <436A7D4B.8080109@eclis.ch>	 <1131054087.27168.595.camel@cog.beaverton.ibm.com>	 <436A8ADB.2090307@eclis.ch> <1131058482.27168.612.camel@cog.beaverton.ibm.com>
In-Reply-To: <1131058482.27168.612.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz a écrit :
> You might check booting w/ noapic to see if that changes the behaviour
> in 2.6.10.

Yes! With a vanilla 2.6.10, the noapic solve the problem and ntpd is happy.


> Jean-Christian: Since it ACPI is involved, have you verified that you're
> running the current BIOS for your system?

More fun now: it look like the BIOS actually used on this mainboard is 
not designed for it, but for an other board!!!

The board is exactly this one "K7N2 Delta-L":
http://www.msi.com.tw/program/support/download/dld/spt_dld_detail.php?UID=436&kind=1
And according to MSI it must use a BIOS version 5.9. But when I enter 
into the BIOS setup the version info say "W6570MS V7.4 081203".

Here is the BIOS version history: 
http://www.msi.com.tw/program/support/bios/bos/spt_bos_detail.php?UID=436&kind=1
The version 7.4 dated 2003-8-12 has a special note:

1. Only for K7N2 Delta-ILSR
2. This BIOS cannot be used on K7N2 Delta-L

Crasy. I use this board without any issue since around two years and 
only found the first problem when upgrading to the kernel 2.6.14!


At least the situation is more clear now.
-- 
Jean-Christian de Rivaz
