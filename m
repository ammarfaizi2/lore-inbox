Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVBOUry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVBOUry (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVBOUqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 15:46:19 -0500
Received: from cliff.niehs.nih.gov ([157.98.192.45]:49830 "EHLO
	cliff.niehs.nih.gov") by vger.kernel.org with ESMTP id S261876AbVBOUlG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 15:41:06 -0500
Message-ID: <42125E57.7080304@niehs.nih.gov>
Date: Tue, 15 Feb 2005 15:40:55 -0500
From: Joe Krahn <krahn@niehs.nih.gov>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kurt Garloff <garloff@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bogus REPORT_LUNS responses breaks SCSI LUN detection
References: <41DF1D96.6030109@niehs.nih.gov> <20050214045100.GA27893@tpkurt.garloff.de>
In-Reply-To: <20050214045100.GA27893@tpkurt.garloff.de>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Garloff wrote:
> On Fri, Jan 07, 2005 at 06:39:02PM -0500, Joe Krahn wrote:
> 
>>There are apparently several devices that return bad data
>>for the REPORT_LUNS query, but do not return an error.
>>The newer kernels only do sequential LUN scans if REPORT_LUNS
>>fails. There may need to be a kernel option to force sequential
>>scans.
> 
> 
> There is.
> Try passing scsi_mod.default_dev_flags=0x40000
> The SUSE initrd will also understand the better memorizable version
> scsi_noreportlun=1.
> 
> Devices known to be broken should be added to the blacklist with
> BLIST_NOREPORTLUN.
> 
> 

Oops; I didn't see that flag. It seems it was added at the same time LUN 
scanning became the default. It would be good to document the 
availability of default_dev_flags in /Documents/scsi.

It appears that the broken RAID systems are based on Maxtronic Arrays, 
such as the Arena Premium 8600. They just released a fixed firmware, so 
the source of the problem should be fixed. (It was also broken for Mac OSX.)

Thanks,
Joe Krahn
