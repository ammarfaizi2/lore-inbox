Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbWD0TV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWD0TV4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 15:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbWD0TV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 15:21:56 -0400
Received: from 10.121.9.213.dsl.getacom.de ([213.9.121.10]:11712 "EHLO
	ds666.l4x.org") by vger.kernel.org with ESMTP id S965008AbWD0TVy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 15:21:54 -0400
Message-ID: <445119CD.40509@l4x.org>
Date: Thu, 27 Apr 2006 21:21:49 +0200
From: Jan Dittmer <jdi@l4x.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060228 Thunderbird/1.5 Mnenhy/0.6.0.104
MIME-Version: 1.0
To: jgarzik@pobox.com
CC: jdi@l4x.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060427185813.GB6039@l4x.org>
In-Reply-To: <20060427185813.GB6039@l4x.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.1.149
X-SA-Exim-Mail-From: jdi@l4x.org
Subject: Re: sata_sil24 resetting controller...
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on ds666.l4x.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jdi@l4x.org wrote:
> so I started to reshape my raid5 array. Since the reshape
> started my kernel log gets swamped with the following messages:
> 
> [4297871.909000] sata_sil24 ata1: resetting controller...
> [4297871.909000] ata1: status=0x50 { DriveReady SeekComplete }
> [4297871.909000] sdc: Current: sense key=0x0
> [4297871.909000]     ASC=0x0 ASCQ=0x0
> [4297873.266000] ata1: error interrupt on port0
> [4297873.266000]   stat=0x80000001 irq=0xb60002 cmd_err=35 sstatus=0x123
> serror=0x0
> 
> The time between these events varies from .5s to up to 10s, resync speed is

Just one more observation:
The time between the messages seems to be correlated to the resync speed.
The faster the resync, the more messages.

Jan
