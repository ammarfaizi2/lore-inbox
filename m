Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWGXXxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWGXXxU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 19:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWGXXxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 19:53:20 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:32523 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932334AbWGXXxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 19:53:19 -0400
Message-ID: <44C55F36.5000701@gentoo.org>
Date: Tue, 25 Jul 2006 01:00:54 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: Tom Walter Dillig <tdillig@stanford.edu>
CC: linux-kernel@vger.kernel.org, w@1wt.eul, kernel_org@digitalpeer.com,
       security@kernel.org, Netdev list <netdev@vger.kernel.org>
Subject: softmac possible null deref [was: Complete report of Null dereference
 errors in kernel 2.6.17.1]
References: <1153782637.44c5536e013a4@webmail>
In-Reply-To: <1153782637.44c5536e013a4@webmail>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Walter Dillig wrote:
> [109]
> 452 net/ieee80211/softmac/ieee80211softmac_io.c
> Possible null dereference of variable "*pkt" in function call
> (include/asm/string.h:__constant_c_and_count_memset) checked at
> (453:net/ieee80211/softmac/ieee80211softmac_io.c)

Either I'm misunderstanding, or this is bogus.

when *pkt is allocated by the various child functions (e.g. 
ieee80211softmac_disassoc_deauth), it is always checked for NULL.

Finally, line 453 does another NULL check.

What is the report trying to say?

Daniel

