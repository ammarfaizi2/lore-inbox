Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263923AbTH1Lzg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 07:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263939AbTH1Lzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 07:55:36 -0400
Received: from 11.ylenurme.ee ([193.40.6.11]:31437 "EHLO linking.ee")
	by vger.kernel.org with ESMTP id S263923AbTH1Lze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 07:55:34 -0400
Message-ID: <3F4DFB44.2080802@linking.ee>
Date: Thu, 28 Aug 2003 14:53:24 +0200
From: Valmar Joandi <valmar@linking.ee>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hugo-lkml@carfax.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-ac4 Adaptec 1210SA lost interrupt , Seagate 120G
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Has there been any changes recently? I search with google for that patch 
but could'nt find anything, maybe I missed something?
And how about 2.6 kernel + 1210sa + sata seagate 120G?


-----------------------------FWD 
MESSAGE--------------------------------------------------
Re: 2.4.21-ac4 Adaptec 1210SA lost interrupt , Seagate 120G
From: Hugo Mills (hugo-lkml@carfax.org.uk)
Date: Mon Jul 07 2003 - 17:44:01 EST

    * Next message: Dmitry Torokhov: "Re: [PATCH] Synaptics: support for 
pass-through port (stick)"
    * Previous message: Doug McNaught: "Re: question about linux tcp 
request queue handling"
    * In reply to: Elmer: "2.4.21-ac4 Adaptec 1210SA lost interrupt , 
Seagate 120G"
    * Messages sorted by: [ date ] [ thread ] [ subject ] [ author ]

On Tue, Jul 08, 2003 at 12:42:32AM +0300, Elmer wrote:
 > Tried them on every imaginable way:
 >
 > 1. 2.4.21 + my own siimage slight patch, 2.4.21 + simage from ac4,
 > pure 2.4.21-ac4
 > 2. apic, noapic, localapic
 > 3. uni,smp motherboards, 4 of them
 > 4. modules, compiled in,
 > 5. all of options from cards bios
 >
 > /proc/interrupts reports 0 interrupts for ide2,3 , whatever I do.
 >
 > after bootup, after attacking ide-disk driver, there are lost interrupts.
 > it recognises disk as correct type, but no communication except:
 >
 > 1. under XP it works (but there was no linux at that mb)
 > 2. hdparm lets change few flags under linux, but no -X succeeds
 > 3. after waiting for minute those timeouts and booting up, then
 > /proc/ide/ide2/hde/* reports sensible correct information
 >
 > I have the card for few more days, anything to try ?

   I've tried this card with all of the hdparm options that I could
think of. I got no success either. However, Andre Hedrick claims[1] to
have got the SiI3112 and 3114 working in his tree (a couple of weeks
ago). He's testing it[2] before release.

   Hugo.

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=105622034606015&w=2

[2] I believe that one of the tests is whether he's got paid for the
work by the people who contracted him to do it, which is where I
suspect the real delay is.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
                --- If it ain't broke,  hit it again. ---                


