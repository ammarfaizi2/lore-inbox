Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbVI2Vxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbVI2Vxo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 17:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVI2Vxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 17:53:44 -0400
Received: from smtp.cogeco.net ([216.221.81.25]:42434 "EHLO fep7.cogeco.net")
	by vger.kernel.org with ESMTP id S932365AbVI2Vxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 17:53:43 -0400
Message-ID: <433C6261.2050202@rtr.ca>
Date: Thu, 29 Sep 2005 17:53:37 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, Justin Piszcz <jpiszcz@lucidpixels.com>,
       Nuno Silva <nuno.silva@vgertech.com>
Subject: Re: Linux SATA S.M.A.R.T. and SLEEP? -- was [PATCH libata-dev-2.6:passthru]
 passthru fixes
References: <20050929185245.GA28483@tuxdriver.com>
In-Reply-To: <20050929185245.GA28483@tuxdriver.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:
> You probably want this patch as well, at least the first hunk.
> It fixes a potential memory leak that could cause lock-ups when using
> hdparm or smartctl/smartd.
> 
> John
> ---
> Fix a few problems seen with the passthru branch:
> 
> - leaked scsi_request on buffer allocate failure
> - passthru sense routines were refering to tf->command
>   which is not read in tf_read, instead use drv_stat for
>   status register.
> - passthru sense passed back to user on ata_task_ioctl
> 
> Patch is against the current libata-dev passthru branch.
> 
> Signed-off-by: Jeff Raubitschek <jhr@google.com>
...

When I tried that patch recently, smartctl stopped working.
Reverted.  Works again.

??
