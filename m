Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267646AbUHELcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267646AbUHELcf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 07:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267648AbUHELcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 07:32:35 -0400
Received: from web50802.mail.yahoo.com ([206.190.38.111]:54457 "HELO
	web50802.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267646AbUHELcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 07:32:32 -0400
Message-ID: <20040805113228.51997.qmail@web50802.mail.yahoo.com>
Date: Thu, 5 Aug 2004 04:32:28 -0700 (PDT)
From: mr <jkerdawn@yahoo.com>
Subject: using isa - performance degrade?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

i'm running 2.4.26 (debian) with sd's attached to an
ncr53c8xx-scsi controller. since the sys is a p133
(the machine acts as a router/gw and knfs) performance
isn't all the matters...but i was wondering..

if i would plug the vga-card to an isa slot(now
unused& not compiled), one pci would get free to hold
an AHA-2940 scsi controller, so i could split disks
over the two scsihosts & add a few more. 
will the additional use of the isa-bus give me a
performance impact?

sym0: <810> rev 0x2 on pci bus 0 device 12 function 0
irq 10
  Vendor: IBM       Model: DNES-309170       Rev: SA30
  ANSI SCSI revision: 03
  Vendor: QUANTUM   Model: FIREBALL1080S     Rev: 1Q09
  ANSI SCSI revision: 02
  Vendor: QUANTUM   Model: VP32210           Rev: 81H8
  ANSI SCSI revision: 02
  Vendor: IBM       Model: DDRS-34560        Rev: S97B
  ANSI SCSI revision: 02
another DDRS-34560...cdroms...

i won't have a problem with pci-throughput. afaik,
with 33MHz-pci it shouldn't be a problem to get data
from queries over the bus - those are not quite fast
disks (hdparm -t 4,4MBs-fireball, 5,2MBs-VP,
>8MBs-IBMs). since i also heard about poor performance
of the adaptec-2940, will it be wise to use the second
adapter?

another issue i'm poring about is using tagged command
queueing(VP) / linked commands(fireball) on two disks
holding a cache for squid on a reiserfs + swaps. will
it improve performance or is the elevator/schedular
enough? i know how to set command queueing at bootup
but i'm clueless if there is a programm (scsi-tools?
do i need sg?) to set various other options for the
drives/host?

please cc to jkerdawn<at>yahoo.com 
-i've been on the list for a while, but the
traffic..=(

thanks a lot & regards

ritch.


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
