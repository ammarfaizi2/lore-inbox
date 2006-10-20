Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWJTI4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWJTI4O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 04:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWJTI4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 04:56:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:6035 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932213AbWJTI4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 04:56:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=MK+f2o8r8xMV5rKl+AC443viUxgU2czN0I2HAdeCUCGkdRRaFTvQQAbv/54QWzLricQMmCIL2+RR6NZNd3fPcas6P7jwLaZOwme+/Lb8HsOQG6tTVWBB9DljKf34i+7wAwFxFiTckVyps7iyrSsTUNfJg3RGRwbMyfuJwBVeNOA=
Message-ID: <45388F24.6000407@gmail.com>
Date: Fri, 20 Oct 2006 17:56:04 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060928)
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Robert Wruck <wruck@tweerlei.de>,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.19-rc2] SATA boot problems
References: <4537697C.7080500@tweerlei.de> <4537DEFC.5050404@rtr.ca>
In-Reply-To: <4537DEFC.5050404@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Hi.  I'm copying your posting for the linux-ide mailing list,
> where the libata designers hang out.
> 
> Robert Wruck wrote:
>> Hi,
>>
>> I'm having problems booting from a SATA disk with 2.6.19-rc2.
>> Grub loads fine, but when the kernel boots, it *sometimes* ends up with
>> VFS: Cannot open root device "sda5" or unknown-block(0,0)
>>
>> The strange thing is that this happens only in 2/3 of the boot attempts.
>> If I reset the machine, the next attempt is likely to succeed.
>> I first noted this when switching from 2.6.17 (2.6.17.11, IIRC) to
>> 2.6.18 and it persists in 2.6.19-rc2 (Windows does not encounter similar
>> problems on the same machine).
>>
>> I attached a diff of a successful and an unsuccessful netconsole log
>> below. It seems that the drive is sometimes simply not detected...
>> I'm not using an initrd and changing the kernel command line from
>> root=/dev/sda5 to root=0x0805 did not help.
>>
>> The controller is:
>> 00:1f.2 IDE interface: Intel Corporation 82801FB/FW (ICH6/ICH6W) SATA
>> Controller (rev 03)
>>
>> Any ideas? Please CC me, as I'm not subscribed.
>> Robert

Can you give a shot at the latest -mm (2.6.19-rc2-mm2)?  It contains 
device-detection-via-polling which is supposed to fix problems similar 
to yours.

-- 
tejun
