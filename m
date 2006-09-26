Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWIZFI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWIZFI2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWIZFI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:08:28 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:55071 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750978AbWIZFI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:08:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SKT/wyXXrnGFGo1o1FrPu8WEJ0bAGus18b39bzGx5bxl1FBLSXfwoCg3xZRhcUVTVBx2Cxr9mhzl3i12KWS43sqeUDNC1ljo0kkYWw8cZxCCLeXJ6zmEAmRTmEK/cZ+QibOr4ewA1hjH75HzHGTTneaFBCHcoly0AIhDGFV1VRE=
Message-ID: <4518B5C4.6020207@gmail.com>
Date: Tue, 26 Sep 2006 14:08:20 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Stephen Atkins <satkins@skircr.com>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: Serial ATA (sii3512a) support
References: <4515624A.4090100@skircr.com>
In-Reply-To: <4515624A.4090100@skircr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cc'ing linux-ide]

Stephen Atkins wrote:
> Hello everyone.  I'm just wondering what the status is for the Silicon
> Image 3512a serial ata support is.

Pretty good actually.

> I was using gentoo-sources 2.6.12 my Seagate drives worked fine.  I'm
> now running a gentoo-sources 2.6.15-r1 and support has broken.  The same
> thing with gentoo-sources 2.6.17-r8.  I've added my drives to the
> sata_sil.c black list (one of them was missing) but I still get
> "Abnormal status 0x58 on port ..." errors.  Which essentially crashes my
> machine.

That looks like transmission failure and to me it doesn't seem to be a 
driver problem and please don't add your drive to sata_sil blacklist. 
The blacklist is for very specific cases and won't fix your problem 
other than sometimes hiding the real problem by slowing things down a lot.

When does such error occur?  Is it reproducible?  How often does it occur?

> Unfortunately I don't have the 2.6.12 kernel from Gentoo any more as I
> did a emerge --sync and it got rid of it.  Also some of the other
> drivers I'm using need more recent kernel versions.
> 
> Just some notes on my MB/chipsets.  I've got a Gigabyte GA-7N400Pro2
> with an nForce2 chipset.  It has a on board SATA which the manual says
> is a Sil3112 but the bios reports it as a Sil3512a.  I've got a single 6
> gig IDE as my boot device and root dir.  There are also two SATA drives
> both are Seagates.  One is a ST3250823AS (250 gigs) and a ST3120026AS
> (120 gigs).  I know the Seagate drives have some issues and hence the
> black list.
> 
> Just wondering if there is anything I can do to make these things work
> in some of the latest kernels.  Thanks for you help.

Can you give a shot at 2.6.18?  It contains improved EH which should be 
able to recover from the condition you described.

-- 
tejun
