Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUHJImh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUHJImh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUHJImh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:42:37 -0400
Received: from ipx-98-250-190-80.ipxserver.de ([80.190.250.98]:35335 "EHLO
	taytron.net") by vger.kernel.org with ESMTP id S262138AbUHJIme
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:42:34 -0400
Message-ID: <41188A64.3090204@tuxbox.org>
Date: Tue, 10 Aug 2004 10:42:12 +0200
From: Florian Schirmer <jolt@tuxbox.org>
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Harald_K=FCthe?= <Harald.Kuethe@controlware.de>
CC: linuxppc-embedded@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][PPC32] 2.4.27: fixes for 8xx fec.c
References: <s1189c52.091@post2.controlware.de>
In-Reply-To: <s1189c52.091@post2.controlware.de>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>+
>+#ifndef	CONFIG_USE_MDIO
>+	fec_restart (dev, 0);
>+#endif
>+
> 	netif_start_queue(dev);
> 	return 0;	/* Success */
> #endif	/* CONFIG_USE_MDIO */
>  
>

Just a minor hint: you don't need the #ifndef CONFIG_USE_MDIO guard 
since you're already in the non MDIO branch (see #endif comment).

Greetings,
  Florian
