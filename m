Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVE2NBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVE2NBg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 09:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVE2NBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 09:01:35 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:22425 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261272AbVE2NB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 09:01:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=HMFnspa60e6KzjImS4OmG6JGKVzeUUDjKr18gEGW72BdjXnxVMIQrsPlwsY0EcmC13FpYSwoYq66sXHgxuYYO2l6cZsHegQq4OaxAluE06vOSl4LELsEv7TlcjrIqxDKlNsHe416261mToELxcAU+xXVDopqrD5bt8vZt9rLb2g=
Message-ID: <4299BD23.6010004@gmail.com>
Date: Sun, 29 May 2005 15:01:23 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050523)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de> <429793C8.8090007@gmail.com> <42979C4F.8020007@pobox.com> <42979FA3.1010106@gmail.com> <20050528121258.GA17869@suse.de>
In-Reply-To: <20050528121258.GA17869@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote,

>
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
Hi Jens,

thanks for the short info now my next question how many queue depths
are healty and wanted?

For my Intel Corporation 82801GR/GH (ICH7 Family) Serial ATA Storage
Controllers cc=AHCI (rev 01)
and Samsung Hd160JJ SATAII drive the default queue is 30

    ioGL64NX_MACH~# cat /sys/block/sda/device/{model,queue_depth}
    SAMSUNG HD160JJ
    30

    hdparm -Tt /dev/sda

    /dev/sda:
    Timing cached reads: 4724 MB in 2.00 seconds = 2360.00 MB/sec
    Timing buffered disk reads: 164 MB in 3.02 seconds = 54.28 MB/sec

On random access the drives is a bit noisy but the subjective feeling is
great
everything goes a bit faster.

And whats about the option /sys/block/sdx/device/queue_type = simple
what can be done here?

Thanks in advance
Best regards
Michael



