Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWFGVns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWFGVns (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 17:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWFGVns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 17:43:48 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:27342
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932427AbWFGVns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 17:43:48 -0400
Message-ID: <4487488F.3010100@microgate.com>
Date: Wed, 07 Jun 2006 16:43:43 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, khc@pm.waw.pl
Subject: Re: [PATCH] fix generic HDLC synclink mismatch build error
References: <1149694978.12920.14.camel@amdx2.microgate.com> <20060607143138.62855633.rdunlap@xenotime.net>
In-Reply-To: <20060607143138.62855633.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> See my new patch below.  All done in Kconfig, no
> source file changes needed.  Highly preferable. :)

The effect is the exact same as mine (if there is a mismatch
then generic HDLC support for synclink is silently disabled),
and your patch is against a patch that has already been dropped.

The only difference is the granularity of enabling
the HDLC option for individual synclink adapter types,
which is not really an issue (as this is not in <= 2.6.16 anyways).

I'd prefer to stick with my patch as it is simpler,
and maintains compatibility with the way thing are done
in <= 2.6.16 (customer documentation does not need updating).

Thanks,
Paul

