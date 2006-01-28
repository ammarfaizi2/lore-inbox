Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWA1TrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWA1TrR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 14:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWA1TrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 14:47:17 -0500
Received: from relay03.pair.com ([209.68.5.17]:8720 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1750717AbWA1TrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 14:47:15 -0500
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: Jens Axboe <axboe@suse.de>
Subject: Re: memory leak in scsi_cmd_cache 2.6.15
Date: Sat, 28 Jan 2006 13:46:48 -0600
User-Agent: KMail/1.9
Cc: Nix <nix@esperi.org.uk>, Ariel <askernel2615@dsgml.com>,
       Jamie Heilman <jamie@audible.transient.net>,
       Arjan van de Ven <arjan@infradead.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz> <87ek2td4i9.fsf@amaterasu.srvr.nix> <20060128192714.GI9750@suse.de>
In-Reply-To: <20060128192714.GI9750@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601281347.10531.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 January 2006 13:26, Jens Axboe wrote:
> It's not a bad data point, it just confirms that setting ->ordered_flush
> to 0 in the SATA drivers will fix the leak. So really, it's as expected.
> So far apparently nobody tried it, suggested it twice.

In case you still wanted the data point, I just set ordered_flush to 0 on my 
ata_piix and the slab leak disappeared.

Thanks,
Chase
