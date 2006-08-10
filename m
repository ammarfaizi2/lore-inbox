Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161135AbWHJIcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161135AbWHJIcd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 04:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161137AbWHJIcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 04:32:33 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:22198 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161135AbWHJIcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 04:32:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=duWz177JTk66lSFJAcF6zE0aZipnPxdmrkd2wy2t6ynjk0bAF/v9en83wUnH94pTNnqm6UeNOFuTCnJLG4dS6l3R4iYlLTrTfy1CZCfRk3bt8xbsd9QmDHdkff0kKLfMmFdFMUeQTcG8O0bVKJhN+EsNlU0vWRT3kH9PkSyvtUs=
Message-ID: <44DAEF19.6000401@gmail.com>
Date: Thu, 10 Aug 2006 17:32:25 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Ben Buxton <kernel@bb.cactii.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: SATA S3 resume problems on HP NC6400 notebook
References: <20060807211146.GA17092@cactii.net>
In-Reply-To: <20060807211146.GA17092@cactii.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Buxton wrote:
> After a while, there are SCSI errors reported, naturally.
> 
> And this is the error with 2.6.17.7 vanilla.
> 
> ata1: handling error/timeout
> ata1: port reset. p_is 400000 is 0 pis 400000 cmd 2004 tf 80 ss 113 se 4050000
> ata1: status=0x50 { DriveReady SeekComplete }
> sda: Current: sense key: No Sense
>     Additional sense: No additional sense information
> Info fld=0x8b8008e
> 
> Which repeats before ext3 gives an error.
> 
> So...what can I do to help get this up and running?

AHCI suspend/resume is already in libata devel tree and the latest -mm 
should also have it.  I don't think it will be merged into 2.6.18-rcX 
though.  It will probably go into 2.6.19.  So, give a shot at 
2.6.18-rc3-mm2.

-- 
tejun
