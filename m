Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbUKDOZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbUKDOZs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 09:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbUKDOZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 09:25:47 -0500
Received: from mail9.messagelabs.com ([194.205.110.133]:50891 "HELO
	mail9.messagelabs.com") by vger.kernel.org with SMTP
	id S262235AbUKDOYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 09:24:04 -0500
X-VirusChecked: Checked
X-Env-Sender: icampbell@arcom.com
X-Msg-Ref: server-15.tower-9.messagelabs.com!1099578242!13504300!1
X-StarScan-Version: 5.4.2; banners=arcom.com,-,-
X-Originating-IP: [194.200.159.164]
Subject: Re: is killing zombies possible w/o a reboot?
From: Ian Campbell <icampbell@arcom.com>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org, Jan Knutar <jk-lkml@sci.fi>,
       Tom Felker <tfelker2@uiuc.edu>
In-Reply-To: <200411040907.22684.gene.heskett@verizon.net>
References: <200411030751.39578.gene.heskett@verizon.net>
	 <200411040739.01699.gene.heskett@verizon.net>
	 <1099573266.2856.40.camel@icampbell-debian>
	 <200411040907.22684.gene.heskett@verizon.net>
Content-Type: text/plain
Organization: Arcom Control Systems
Date: Thu, 04 Nov 2004 14:24:00 +0000
Message-Id: <1099578240.2856.51.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-IMAIL-SPAM-VALHELO: (584253662)
X-IMAIL-SPAM-VALREVDNS: (584253662)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-04 at 09:07 -0500, Gene Heskett wrote:
> [root@coyote root]#  cat /proc/sys/kernel/sysrq
> 0

Aha :-)

> And no, I'm not turning it off anyplace in the boot proceedure.

Something must be -- you can see in drivers/char/sysrq.c that
sysrq_enabled is set to 1 by default and according to bkbits.net it has
been that way since at least 2.4.0.

does the following not come up with any culprits?
	# grep -r sysrq /etc

Ian.

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been virus scanned by MessageLabs.
