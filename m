Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424613AbWKQAFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424613AbWKQAFP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 19:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424614AbWKQAFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 19:05:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:4251 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1424613AbWKQAFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 19:05:13 -0500
Date: Thu, 16 Nov 2006 12:01:12 -0800
From: Greg KH <greg@kroah.com>
To: Edward Falk <efalk@google.com>
Cc: linux-kernel@vger.kernel.org, jens.axboe@oracle.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Introduce block I/O performance histograms
Message-ID: <20061116200112.GA27089@kroah.com>
References: <455BD7E8.9020303@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455BD7E8.9020303@google.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2006 at 07:15:52PM -0800, Edward Falk wrote:
> This patch introduces performance histogram record keeping for block 
> I/O, used for performance tuning.  It is turned off by default.
> 
> When turned on, you simply do something like:
> 
> # cat /sys/block/sda/read_request_histo
> rows = bytes columns = ms
>         10      20      50      100     200     500     1000    2000
>    2048 5       0       0       0       0       0       0       0
>    4096 0       0       0       0       0       0       0       0
>    8192 17231   135     41      10      0       0       0       0
>   16384 4400    24      6       2       0       0       0       0
>   32768 2897    34      4       4       0       0       0       0
>   65536 7089    87      5       1       2       0       0       0

Eeek, no, sysfs is for ONE VALUE PER FILE please.

Yes, I know there are some other sysfs files that do not follow this
rule, and we are working on fixing some of them, but please, don't add
new ones that do violate this rule.

thanks,

greg k-h
