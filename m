Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266379AbUFWQfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266379AbUFWQfV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 12:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266576AbUFWQfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 12:35:20 -0400
Received: from ool-44c1e325.dyn.optonline.net ([68.193.227.37]:17287 "HELO
	dyn.galis.org") by vger.kernel.org with SMTP id S266379AbUFWQfH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 12:35:07 -0400
Mail-Followup-To: hugo-lkml@carfax.org.uk,
  jgarzik@pobox.com,
  linux-kernel@vger.kernel.org,
  linux-ide@vger.kernel.org
MBOX-Line: From george@galis.org  Wed Jun 23 12:35:06 2004
Date: Wed, 23 Jun 2004 12:35:05 -0400
From: George Georgalis <george@galis.org>
To: Hugo Mills <hugo-lkml@carfax.org.uk>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: SIIMAGE sata fails with 2.6.7
Message-ID: <20040623163505.GA1068@trot.local>
References: <20040622170557.GA16617@trot.local> <40D895C6.3070306@pobox.com> <20040623141659.GD30929@trot.local> <20040623153235.GD1010@carfax.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623153235.GD1010@carfax.org.uk>
X-Time: trot.local; @732; Wed, 23 Jun 2004 12:35:06 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 04:32:35PM +0100, Hugo Mills wrote:
>On Wed, Jun 23, 2004 at 10:16:59AM -0400, George Georgalis wrote:
>> On Tue, Jun 22, 2004 at 04:25:42PM -0400, Jeff Garzik wrote:
>> >does sata_sil driver work for you?
>> 
>> I have this file,
>> 
>> -rw-r--r--    1 500      500         12779 Jun 16 01:18 ./drivers/scsi/sata_sil.c
>> 
>> but I don't see a switch for it in the config, also I'm not sure where
>> the most recent patch for it is.
>
>   The option is under 
>
>Device Drivers  ---> 
>  SCSI device support  --->
>    SCSI low-level drivers  --->
>      [*]  Serial ATA  (SATA)
>      < >   ServerWorks Frodo / Apple K2 SATA support (EXPERIMENTAL) (NEW)
>      < >   Intel PIIX/ICH SATA support (NEW)
>      < >   Promise SATA support (NEW)
>      <*>   Silicon Image SATA support (NEW)
>      < >   VIA SATA support (NEW)
>      < >   VITESSE VSC-7174 SATA support (NEW)
>

Thanks, I discovered and was building that after I discovered the
"development and/or incomplete code/drivers" option is also required.

My system would not boot without SIIMAGE too, is that expected?
Should there be a dependency in menuconfig?

Sad news, at about 800 Mb, pdflush stopped completing and the device
was blocked.

Oooh, guess I needed to mount as a scsi dev now? but I don't see any
scsi devices available... must I first not mount the hdc partitions?

// George



-- 
George Georgalis, Architect and administrator, Linux services. IXOYE
http://galis.org/george/  cell:646-331-2027  mailto:george@galis.org
Key fingerprint = 5415 2738 61CF 6AE1 E9A7  9EF0 0186 503B 9831 1631

