Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264664AbTE1Kh1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 06:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264666AbTE1Kh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 06:37:27 -0400
Received: from sj-core-1.cisco.com ([171.71.177.237]:39678 "EHLO
	sj-core-1.cisco.com") by vger.kernel.org with ESMTP id S264664AbTE1KhZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 06:37:25 -0400
Message-Id: <5.1.0.14.2.20030528204534.025027d0@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 28 May 2003 20:50:05 +1000
To: Jeff Garzik <jgarzik@pobox.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: [BK PATCHES] add ata scsi driver
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030527152113.GA21744@gtf.org>
References: <1054047595.1975.64.camel@mulgrave>
 <Pine.LNX.4.44.0305270734320.20127-100000@home.transmeta.com>
 <1054047595.1975.64.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:21 AM 27/05/2003 -0400, Jeff Garzik wrote:
>ATA defines WWN too...  I'm curious what the format is?  uuid-ish?

FC uses a 64-bit identifier for a WWN.

you end up with things like "50:00:0e:10:00:00:01:1c".
ironically, FC switching doesn't actually 'use' the WWN but a 24-bit FC_ID.

for things like mappings -- who knows -- perhaps WWN is good -- perhaps 
something like a serial # is also good -- perhaps both are good?

         mel-stglab-mds9509-1# show scsi-target lun vsan 1

         - DF350F from HITACHI (Rev 0000)
           FCID is 0x7f0002 in VSAN 1, PWWN is 50:00:0e:10:00:00:01:1c
           ------------------------------------------------------------------------------
           LUN    Capacity  Status  Serial Number    Device-Id
                  (MB)
           ------------------------------------------------------------------------------
           0x0    16651     Online                   C:2 A:0 T:1 HITACHI 
D35067950000
           0x1    16651     Online                   C:2 A:0 T:1 HITACHI 
D35067950001

         - ST318452FC from HP (Rev HP03)
           FCID is 0x7f01da in VSAN 1, PWWN is 22:00:00:04:cf:8c:1f:95
           ------------------------------------------------------------------------------
           LUN    Capacity  Status  Serial Number    Device-Id
                  (MB)
           ------------------------------------------------------------------------------
           0x0    17920     Online  3EV0JVQJ         C:1 A:0 T:3 
20:00:00:04:cf:8c:1f:95
         [..]


cheers,

lincoln.

