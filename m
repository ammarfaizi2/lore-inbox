Return-Path: <linux-kernel-owner+w=401wt.eu-S1161291AbWLPR7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161291AbWLPR7T (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 12:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161292AbWLPR7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 12:59:19 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:37207 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161291AbWLPR7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 12:59:18 -0500
Date: Sat, 16 Dec 2006 18:58:28 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Make entries in the "Device drivers" menu individually
 selectable
In-Reply-To: <4583D008.40806@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.61.0612161856490.30896@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0612140325340.13847@localhost.localdomain>
 <4583D008.40806@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 16 2006 11:52, Stefan Richter wrote:
>Robert P. J. Day wrote on 2006-12-14:
>>   i've posted on this before so here's a slightly-updated patch that
>> uses the kbuild "menuconfig" feature to make numerous entries under
>> the Device drivers menu selectable on the spot.
>
>Works for me, but I don't see a lot of benefit from it. Actually I see
>two disadvantages of the patch:
>
> - Without the patch, the choice of y/m/n for a subsystem and the help
>text is put aside into the submenu. I find this current layout simpler
>and quieter.

When using "Help" on a (normal) menu element, the menuconfig help pops up.
(This is probably what you mean.)
This could be changed for menuconfig elements.

> - There are two out-of-tree FireWire drivers for special purposes (one
>bus sniffer, one remote debugging aid) which might perhaps be candidates
>for integration into mainline. These drivers do not use the ieee1394
>base driver. (They just don't need to.) With your patch, disabling the
>subsystem menu would not only disable the subsystem core driver (which
>is correct) but would also hide the choice for such extra drivers which
>do not need the core driver. Or vice versa, enabling the submenu would
>enable the core driver, even though not all subsystem choices need the
>core driver.

And in case there is a

   menu FOO

   config BAR

   config BAZ

   endmenu

just don't convert these to menuconfig. Issue set :)



	-`J'
-- 
