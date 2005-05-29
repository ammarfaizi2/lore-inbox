Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVE2SLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVE2SLN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 14:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVE2SLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 14:11:13 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:56504 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261392AbVE2SLC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 14:11:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=QD0iP7Ybjh7lkm3lltPfE8OcABVU7gUVJPtyhDf7ckwZNgYUSwtTOYJBz8CPKOpFkuVYVY21TH/IqE/VlU38tnXKU600F9o2Jat/xjlEN3HJrj3bQ1O4cdCY6mYeFnof/ep6C0q0TCk0xYYV/HkQIOPS8JokABpm+XL2Jli6ISM=
Message-ID: <429A05AC.9020805@gmail.com>
Date: Sun, 29 May 2005 20:10:52 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050523)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de> <429793C8.8090007@gmail.com> <42979C4F.8020007@pobox.com> <42979FA3.1010106@gmail.com> <20050528121258.GA17869@suse.de>
In-Reply-To: <20050528121258.GA17869@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe schrieb:

>There's really nothing to be tuned. If NCQ is enabled for your drive, it
>will be printed in dmesg after the lba48 flag, such as:
>
>ata1: dev 0 ATA, max UDMA/133, 488281250 sectors lba48 ncq
>
>If you don't see NCQ there, your drive/controller doesn't support it.
>Likewise you will have a queueing depth of > 1 if NCQ is enabled, check
>/sys/block/sdX/device/queue_depth to see what the configured queueing
>depth is for that device.
>
>  
>
Hello again,

the queue_depth of 30 is okay? On boot the CFQ scheduler tells:

      cfq: depth 4 reached, tagging now on

This only appears with AHCI enabled what does that mean?

Also a question which options can be set in queue_type?

Best regard and thanks for help

Greets
    Michael


