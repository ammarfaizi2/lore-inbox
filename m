Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbTFDHSV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 03:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbTFDHSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 03:18:21 -0400
Received: from [151.17.201.167] ([151.17.201.167]:24581 "EHLO mail.teamfab.it")
	by vger.kernel.org with ESMTP id S263011AbTFDHSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 03:18:20 -0400
Message-ID: <3EDD9E5C.9060902@teamfab.it>
Date: Wed, 04 Jun 2003 09:23:08 +0200
From: Luca Montecchiani <luca.montecchiani@teamfab.it>
Organization: TeamSystem Spa
User-Agent: Mozilla/5.0 (X11; U; Linux i686; it-IT; rv:1.3.1) Gecko/20030519
X-Accept-Language: it, en, en-us
MIME-Version: 1.0
To: Narayan Desai <desai@mcs.anl.gov>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: partition table problem with 2.4.21-rc7
References: <87brxemtev.fsf@mcs.anl.gov>
In-Reply-To: <87brxemtev.fsf@mcs.anl.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Narayan Desai ha scritto:

> When i boot 2.4.21-rc7, i get the error:
> Partition check:
>  hda:end_request: I/O error, dev 03:00 (hda), sector 0
> end_request: I/O error, dev 03:00 (hda), sector 2
> end_request: I/O error, dev 03:00 (hda), sector 4
> end_request: I/O error, dev 03:00 (hda), sector 6
> end_request: I/O error, dev 03:00 (hda), sector 0
> end_request: I/O error, dev 03:00 (hda), sector 2
> end_request: I/O error, dev 03:00 (hda), sector 4
> end_request: I/O error, dev 03:00 (hda), sector 6
>  unable to read partition table
> 
> after this, the system is able to mount a partition on this disk
> properly. can anyone shed any light on this? This didn't happen with
> pre3. btw, devfs is enabled, if that makes any difference. a config is
> attached.

I've have that annoying messages too and I've verified that the
source of the problem is :

> CONFIG_BLK_DEV_IDEDISK=m

the ide code check the partition-table twice, but the first
time without the ide-disk module and so the error...

Alan ?




