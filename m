Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWDZOvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWDZOvZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 10:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbWDZOvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 10:51:25 -0400
Received: from www.rsbac.org ([81.169.139.228]:12782 "EHLO www.rsbac.org")
	by vger.kernel.org with ESMTP id S932458AbWDZOvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 10:51:25 -0400
From: Michal Purzynski <michal@rsbac.org>
Organization: RSBAC
To: linux-kernel@vger.kernel.org
Subject: pcmcia subsystem completely broken
Date: Wed, 26 Apr 2006 16:51:13 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604261651.18350.michal@rsbac.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey,

i'd like to ask how do i cope with new pcmcia subsystem which was introduced 
after 2.6.13. previous one was working very well for me, yet i cannot get my 
most important pcmcia card working with recent kernels. this card is an 
Option Globetrotter GPRS pcmcia card, exposing "serial port" to linux when 
properly detected.due to some braindamage linux is unable to detect this 
serial port properly until i configure replacing CIS during start - than it 
works. but, linux is not looking for it automagically when putting file 
in /lib/firmware, all has to be forced manually in /etc/pcmcia/config, like 
this
card "Option Wireless Technology GSM/GPRS GlobeTrotter"
#Use Manufacturing ID to match all GlobeTrotter variants
manfid 0x0013, 0x0000
cis "cis/GLOBETROTTER.cis"
bind "serial_cs"

as you can see, i'm using old pcmcia-cs tools, since it's not possible to 
replace firmware on demand with pcmciautils - 1st. hence first question - 
when it will be possible ? i supposed old tools will finally stop working and 
i'll be fried after that change.

second problem with it - even after serial port is detected properly, i'm 
still unable to communicate with that card, no AT command is delivered, no 
reaction from card.

what can be wrong with new pcmcia subsystem ? once again - it was working 
excelent with old code, pre 2.6.13.

machine is an Apple PowerBook G4 laptop, revision 5,4.__

CC me, i'm not subscribed
