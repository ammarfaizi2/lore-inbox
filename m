Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUGXUC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUGXUC1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 16:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUGXUC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 16:02:27 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:44685 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S262450AbUGXUCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 16:02:24 -0400
Message-ID: <4102BFE9.3070906@tlinx.org>
Date: Sat, 24 Jul 2004 13:00:41 -0700
From: L A Walsh <lkml@tlinx.org>
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS subnet access problems
References: <40FF1FE7.4050403@tlinx.org>
In-Reply-To: <40FF1FE7.4050403@tlinx.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem was had SuSE 9.0 manpages for 2.4 kernel loaded but had upgraded 
to 2.6.
Getting new manpages from SuSE 9.1 solved my ignorance! :-)

Thanks to those who clued me in.

Blessings!
-linda


L A Walsh wrote:

> Jul 21 00:15:54 ishtar nfsd[1590]: Unauthorized access by NFS client 
> 192.168.3.2.
> Jul 21 00:15:58 ishtar last message repeated 5928 times
>
> I wanted to give ro access to all clients on a 192.168.3.0/26 network 
> to a "/Share"
> directory, and rw to a few, but I've never managed to get the network 
> access
> statement to work correctly.  Finally I switched to a /24 network to 
> make netmasks more cleanI simply removed every thing but the
> 'ro' export of /Share which I thought should work but does not.  The 
> above
> client is an example.
>
> server:
>    inet addr:192.168.3.1  Bcast:192.168.3.255  Mask:255.255.255.0
> /etc/exports:
> /Share          192.168.3.0/24(async,ro,no_subtree_check,nohide)
>
> > showmount -e
> Export list for server:
> /Share   192.168.3.0/24
>
> client:
>    configed as inet addr:192.168.3.2  Bcast:192.168.3.255  
> Mask:255.255.255.0
>
> Client had access when it was specifically given access by hostname, 
> but doesn't
> solve access problems for anonymous dhcp hosts that I bring online as 
> test machines.
>
> Are there some options needed for anon client access?
>
> the kernel seems to indicate it is exporting to the subnet, yet it is 
> denying
> mount permisson...bug, misconfig?
>
> -linda
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

