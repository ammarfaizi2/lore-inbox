Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbULFObj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbULFObj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 09:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbULFObi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 09:31:38 -0500
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:12144
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S261526AbULFO26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 09:28:58 -0500
Message-ID: <41B46CA2.6040705@ev-en.org>
Date: Mon, 06 Dec 2004 14:28:50 +0000
From: Baruch Even <baruch@ev-en.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>, coreteam@netfilter.org
Subject: Re: ip contrack problem, not strictly followed RFC, DoS very much
 possible
References: <41B464B3.8020807@pointblue.com.pl>
In-Reply-To: <41B464B3.8020807@pointblue.com.pl>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Piotr Jaskiewicz wrote:
> If someone has argumentation for 5 days timeout, please speak out. In 
> everyday life, router, desktop, server usage 100s is enough there, and 
> makes my life easier, as many other linux admins.

1. The correct value is 5 days for the case of long idle connections, 
there are such things, and there is no reason to force such connections 
to do keepalive every 100 seconds to stay alive.

2. You can change it in your firewall in 
/proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_established

Baruch
