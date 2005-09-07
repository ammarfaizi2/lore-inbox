Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbVIGOsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVIGOsX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 10:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVIGOsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 10:48:23 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:19468 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932152AbVIGOsW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 10:48:22 -0400
Message-ID: <431EFE93.5050900@tmr.com>
Date: Wed, 07 Sep 2005 10:52:03 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "ATARAID (eg, Promise Fasttrak, Highpoint 370) related discussions" 
	<ataraid-list@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: IDE HPA
References: <87941b4c05082913101e15ddda@mail.gmail.com>	 <87941b4c05083008523cddbb2a@mail.gmail.com>	 <1125419927.8276.32.camel@localhost.localdomain>	 <87941b4c050830095111bf484e@mail.gmail.com>	 <62b0912f0509020027212e6c42@mail.gmail.com>	 <1125666332.30867.10.camel@localhost.localdomain>	 <62b0912f05090206331d04afd3@mail.gmail.com>	 <E1EBCdS-00064p-00@chiark.greenend.org.uk>	 <62b0912f05090209242ad72321@mail.gmail.com>	 <1125680712.30867.20.camel@localhost.localdomain>	 <62b0912f05090210441d3fa248@mail.gmail.com>	 <1125684567.31292.2.camel@localhost.localdomain>	 <1125687557.30867.26.camel@localhost.localdomain>	 <1125688483.31292.20.camel@localhost.localdomain>	 <1125692578.30867.33.camel@localhost.localdomain> <1125695649.31292.45.camel@localhost.localdomain> <431A3249.9040504@pobox.com>
In-Reply-To: <431A3249.9040504@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> It seems to me that one should write an ATA-specific Device Mapper 
> driver, which layers on top of an ATA disk.  The driver obtains the 
> starting location of HPA, then exports two block devices:  one for the 
> primary data area, and one for the HPA.

I've stayed out of this, but that sounds like a perfect solution to move 
the choice back to the user. However, installers still need to be aware 
of it at initial Linux install, and give the user some rational options:
   - ignore it
   - leave alone but visible
   - blow it away and use the whole drive

It feels as if that's where the future disposition needs to be made. I 
do like treating the HPA as a separate drive though.
> 
> For situations where we want the start Linux philosophy -- Linux exports 
> 100% of the hardware capability -- no DM layer needs to be used.  For 
> situations where its better to treat the HPA as a separate and distinct 
> area, the DM driver would come in handy.
> 
> This follows the same philosophy as fakeraid (BIOS RAID):  we simply 
> export the entire disk, and Device Mapper (google for 'dmraid') handles 
> the vendor-proprietary RAID metadata.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
