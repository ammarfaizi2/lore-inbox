Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbVBATJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVBATJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 14:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbVBATJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 14:09:29 -0500
Received: from alog0273.analogic.com ([208.224.222.49]:6016 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262101AbVBATIx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 14:08:53 -0500
Date: Tue, 1 Feb 2005 14:09:00 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Scott Feldman <sfeldma@pobox.com>
cc: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org
Subject: Re: [ANN] removal of certain net drivers coming soon:
 eepro100,?xircom_tulip_cb, iph5526
In-Reply-To: <1107284234.3366.95.camel@sfeldma-mobl.dsl-verizon.net>
Message-ID: <Pine.LNX.4.61.0502011405530.8039@chaos.analogic.com>
References: <E1CuSUy-00063X-LK@rhn.tartu-labor>  <1106939504.18167.364.camel@localhost.localdomain>
  <Pine.SOC.4.61.0502011444310.26768@math.ut.ee>
 <1107284234.3366.95.camel@sfeldma-mobl.dsl-verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2005, Scott Feldman wrote:

> On Tue, 2005-02-01 at 04:48, Meelis Roos wrote:
>>> See if eepro100 works on your 82556 cards.  I would be surprised if it
>>> does.  If it does, maybe it's not that much trouble to add support to
>>> e100.  Let us know.
>>
>> I did add the PCI ID to e100 to to try it with both drivers.
>>
>> In short: both eepro100 and e100 have problems loading the eeprom and
>> don't work at least out of the box.
>
> Thanks Meelis.
>
> I'll send a patch to Jeff to remove 82556 support from eepro100 for now,
> just in case eepro100 sticks around longer.  I believe it was a mistake
> to add it in the first place.  82556 support should not be in there.
>
> -scott

You just need to load mii first. Both of these drivers are working
fine on 2.6.10.

Module                  Size  Used by
HeavyLink              42756  0 
parport_pc             28740  1 
lp                     14092  0 
parport                37192  2 parport_pc,lp
autofs4                20612  0 
rfcomm                 38040  0 
l2cap                  26496  5 rfcomm
bluetooth              48516  4 rfcomm,l2cap
sunrpc                134756  1 
e100                   36224  0               <-------! 
mii                     8192  1 e100          <-------!
ipt_REJECT              9856  1 
[Snipped...]


Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
