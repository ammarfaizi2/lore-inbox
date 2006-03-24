Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751525AbWCXCCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbWCXCCP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 21:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbWCXCCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 21:02:15 -0500
Received: from stinky.trash.net ([213.144.137.162]:50143 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1751518AbWCXCCO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 21:02:14 -0500
Message-ID: <44235324.3080607@trash.net>
Date: Fri, 24 Mar 2006 03:02:12 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Jing Min Zhao <zhaojignmin@hotmail.com>, netdev@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       zhaojingmin@users.sourceforge.net
Subject: Re: Two comments on the H.323 conntrack/NAT helper
References: <20060324001307.GO22727@stusta.de>
In-Reply-To: <20060324001307.GO22727@stusta.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[The hotmail address of the author doesn't work, CCed sourceforge-address]

Adrian Bunk wrote:
> Two comments on the H.323 conntrack/NAT helper:
> - the function prototypes in ip_nat_helper_h323.c are _ugly_,
>   please move them to a header file

Their ugliness is because of the current API, which cleaned up
quite a lot of the surrounding code, but requires this ugliness
from each helper. I would like to keep them visible as a reminder
that a cleaner solution is wanted, but moving them to header
files certainly sound like a good idea to eliminate the risk
of prototype conflicts. But please do this for all helpers
at once.

> - is there a reason for not using EXPORT_SYMBOL_GPL?

I would prefer that too.
