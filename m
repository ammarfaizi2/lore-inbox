Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVGUV7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVGUV7L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 17:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbVGUV7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 17:59:01 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:32609 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261890AbVGUV67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 17:58:59 -0400
Message-ID: <42E01A68.6000002@tls.msk.ru>
Date: Fri, 22 Jul 2005 01:58:00 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lukasz Kosewski <lkosewsk@nit.ca>
CC: jgarzik@pobox.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Add disk hotswap support to libata
References: <42E01024.9030600@nit.ca>
In-Reply-To: <42E01024.9030600@nit.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Kosewski wrote:
[]
> [1]  The SCSI error on 2.6.13-rc3-mm1 that I found:
> 'echo "scsi add-single-device a b c d" > /proc/scsi/scsi'  //works, or 
> no-op if the sd corresponding to that device is there already
> 'echo "scsi remove-single-device a b c d" > /proc/scsi/scsi'  //works
> 'echo "scsi add-single-device a b c d" > /proc/scsi/scsi'  //works
> 'echo "scsi remove-single-device a b c d" > /proc/scsi/scsi'  //FAILS

echo -n 1 > /sys/.../hostA/targetA:B:C/A:B:C:D/delete
still works.  I think.
And (again, I think) this same problem exists with 2.6.11 as well.
At least, I wasn't able to remove-single-device even once (I discovered
this mechanism only recently, haven't tried it with other kernels).

> As such, since the same underlying functions are called by hotplugging, 
> you will only be able to remove a disk from a device once before it 
> fails, until this error is fixed.  I'll look into it as well.

/mjt
