Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbWBAQ3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbWBAQ3V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 11:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbWBAQ3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 11:29:21 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:20629 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964985AbWBAQ3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 11:29:20 -0500
Date: Wed, 1 Feb 2006 17:28:20 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
cc: Denis Vlasenko <vda@ilport.com.ua>, Oliver Neukum <oliver@neukum.org>,
       jerome lacoste <jerome.lacoste@gmail.com>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>, j@bitron.ch,
       mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, James@superbug.co.uk, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <58cb370e0602010756r3973fde7v387c7529b2bd80cd@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0602011722300.22529@yvahk01.tjqt.qr>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> 
 <5a2cf1f60601310424w6a64c865u590652fbda581b06@mail.gmail.com> 
 <200601311333.36000.oliver@neukum.org>  <200601311444.47199.vda@ilport.com.ua>
  <Pine.LNX.4.61.0602011634520.22529@yvahk01.tjqt.qr>
 <58cb370e0602010756r3973fde7v387c7529b2bd80cd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >Do we need to expose IDE master/slave, primary/secondary concepts in Linux?
>> >
>> AFAICS, we do. hda is always primary slave, etc. With the SCSI layer it's
>
>Ehm, primary master and it is not true if you are using host drivers as modules.
>
Whoops, you are right. However, even with, say, an extra PCI IDE controller,
the ordering of the drives within that controller is "as usual", e.g. the order
is "pri ma","pri sl","sec ma","sec sl", of course relative to the start of the
respective controller.

>Moreover providing ordering by IDE driver has been nightmare to maintain
>and can't be done correctly for 100% weird cases.

So how much weird cases do we have?

>> (surprisingly) the other way round, sda just happens to be the first disk
>> inserted (SCA, USB, etc.)
>
>Which is much saner approach from developers' POV.
>
Developer... and about the user/admin? With a sparcbox (ran suse linux 7.3 the
last time it was powered on - 2.4 kernel, no udev - don't complain :),
replugging disks in put them at the end of the 'sd*' naming
chain, effectively killing the features of hotplug the machine itself offered.
(Oh, that OS starting with S.. managed it with the help of the behated/-loved
c?d?t?s? scheme, but that's OT.)



Jan Engelhardt
-- 
