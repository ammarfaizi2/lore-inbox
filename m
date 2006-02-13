Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWBMQI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWBMQI2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWBMQI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:08:28 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:36372 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1750719AbWBMQI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:08:28 -0500
Message-ID: <43F0AEBE.70303@cfl.rr.com>
Date: Mon, 13 Feb 2006 11:07:26 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Kalin KOZHUHAROV <kalin@thinrope.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Filesystem for mobile hard drive
References: <20060212150331.GA22442@clipper.ens.fr> <43EFD6E4.60601@cfl.rr.com> <20060213010701.GA8430@clipper.ens.fr> <43EFEE57.7070009@cfl.rr.com> <dspj6u$s7f$1@sea.gmane.org>
In-Reply-To: <dspj6u$s7f$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Feb 2006 16:09:15.0751 (UTC) FILETIME=[D633DF70:01C630B7]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14265.000
X-TM-AS-Result: No--8.300000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kalin KOZHUHAROV wrote:
> I might be wrong, but I always thought that NTFS has user/group and a bunch
> of other attributes, so it might not be a good idea to replace them hard
> under linux. Or am I wrong? I never used NTFS much, the few windoze machines
> around me use FAT32 for compatibility.
>
> Kalin.

IIRC, NTFS has the capability to store a posix uid and gid, but it is 
never actually used.  There is no good way to get NT to understand 
mappings to linux uid/gids, so the information it puts there is 
useless.  As a result, the Linux NTFS driver just makes all files owned 
by a fixed id you can specify at mount time, or defaults to root. 


