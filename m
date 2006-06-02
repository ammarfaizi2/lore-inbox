Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWFBMHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWFBMHp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 08:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWFBMHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 08:07:45 -0400
Received: from ev1s-67-15-60-3.ev1servers.net ([67.15.60.3]:49552 "EHLO
	mail.aftek.com") by vger.kernel.org with ESMTP id S1751230AbWFBMHp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 08:07:45 -0400
X-Antivirus-MYDOMAIN-Mail-From: abum@aftek.com via plain.ev1servers.net
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:0(59.95.0.166):SA:0(-102.3/1.7):. Processed in 3.847128 secs Process 2300)
From: "Abu M. Muttalib" <abum@aftek.com>
To: <linux-kernel@vger.kernel.org>
Cc: <k.oliver@t-online.de>, <jes@sgi.com>
Subject: Re: __alloc_pages: 0-order allocation failed (Jes Sorensen)
Date: Fri, 2 Jun 2006 17:44:38 +0530
Message-ID: <BKEKJNIHLJDCFGDBOHGMAEKICNAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <mailman.3.1149246001.8252.linux-kernel-daily-digest@lists.us.dell.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have somewhat related problem as mentioned in my previous mail.

I was running one application on a linux-2.4.19-rmk7-pxa1 box with 16 MB RAM
and 16 MB flash. It was all working fine.

I am now trying to run the same application on a linux-2.6.13 box and
intermittently I get OOM-KILLER and killing of a required process. What has
changed between these two kernel version?

Please help.

Thanks and regards,
Abu.

Date: 01 Jun 2006 08:19:32 -0400
From: Jes Sorensen <jes@sgi.com>
Subject: Re: __alloc_pages: 0-order allocation failed
To: Oliver K?nig <k.oliver@t-online.de>
Cc: linux-kernel@vger.kernel.org
Message-ID: <yq0d5dtt6ej.fsf@jaguar.mkp.net>
Content-Type: text/plain; charset=latin-iso8859-15

>>>>> "Oliver" == Oliver K?nig <k.oliver@t-online.de> writes:

Oliver> I run Debian 3.1 (Sarge) with Debian-Kernel 2.4.27-3-686-smp
Oliver> on Dell Poweredge 2850 with the following setup/config:

Oliver> Model: Dell Poweredge 2850 CPU: 2x3.0 GHz RAM: 2 GB SWAP: 1 GB
Oliver> Raid 1 with Dell PowerEdge Expandable RAID controller 4 (SCSI)
Oliver> Kernel: 2.4.27-3-686-smp (CONFIG_HIGHMEM4G=y) Web server:
Oliver> apache2 SQL server: mysql4.1 MTA: exim4

[snip]

Oliver> The server is then so slow tom react that the only way to get
Oliver> rid of the problem is to reset the server.

Oliver> What can we do to fix the problem?

0-order allocations means it cannot get even a single page of free
memory. You also see in the log the the OOM is kicking in. In other
words, totally out of memory.

You have two options, add more swap or add more memory. At the same
time it might be a good idea to try and monitor it to find out which
tasks are chewing away that much memory.

Cheers,
Jes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

