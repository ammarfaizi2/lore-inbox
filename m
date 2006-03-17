Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWCQEqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWCQEqA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 23:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWCQEqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 23:46:00 -0500
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:24740 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751303AbWCQEqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 23:46:00 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: Re: [ck] [PATCH] swsusp reclaim tweaks was: Re: does swsusp suck after resume for you?
Date: Fri, 17 Mar 2006 15:46:02 +1100
User-Agent: KMail/1.8.3
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@suse.cz>, Stefan Seyfried <seife@suse.de>
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <200603162315.09939.rjw@sisk.pl> <200603171528.05961.kernel@kolivas.org>
In-Reply-To: <200603171528.05961.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603171546.03002.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2006 03:28 pm, Con Kolivas wrote:
> Ok here is a kind of directed memory reclaim for swsusp which is different
> to ordinary memory reclaim. It reclaims memory in up to 4 passes with just
> shrink_zone, without hooking into balance_pgdat thereby simplifying that
> function as well.
>
> The passes are as follows:
>  Reclaim from inactive_list only
>  Reclaim from active list but don't reclaim mapped
>  2nd pass of type 2
>  Reclaim mapped

It may need to be made more aggressive with another reclaim mapped pass to 
ensure it frees enough memory. That would be trivial to add.

Cheers,
Con
