Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVGWQTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVGWQTI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 12:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVGWQTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 12:19:08 -0400
Received: from pat.uio.no ([129.240.130.16]:2730 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261800AbVGWQTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 12:19:06 -0400
Subject: Re: HELP: NFS mount hangs when attempting to copy file
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Timothy Miller <theosib@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9871ee5f050720155671cbc376@mail.gmail.com>
References: <9871ee5f050720155671cbc376@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 23 Jul 2005 12:18:52 -0400
Message-Id: <1122135532.8203.5.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.82, required 12,
	autolearn=disabled, ALL_TRUSTED -2.82, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 20.07.2005 Klokka 18:56 (-0400) skreiv Timothy Miller:
> My research suggests that NFS client mounting is kernel-based, so
> that's why I'm posting here.  If there's a more appropriate list to
> post to, I apologise, but I am not a list member.
> 
> I'm having a bit of a problem doing simple copies over an NFS mount. 
> The client is running Linux (2.6.11), and the server is running
> Solaris (5.8).
> 
> When I first boot the client, getting NFS directory listings works
> just fine.  But the instant I try to copy a file (to or from), the NFS
> mount hangs.  While I can still do other network activity (even rlogin
> to the server), any NFS access I try to do after that point hangs,
> including directory listings.
> 
> I have had this same client and server working flawlessly for years. 
> The only change is that the client is now on a VPN (Watchguard SOHO
> box).  However, I have a Sun machine on the same VPN network segment,
> and it can copy files with no problem, so it's not the router/SOHO
> that's blocking anything.  (NIS and DNS also work just fine for both
> machines.)

I beg to disagree. A lot of these VPN solutions are unfriendly to MTU
path discovery over UDP. Sun uses TCP by default when mounting NFS
partitions. Have you tried this on your Linux box?

Cheers,
  Trond

> Also, after it hangs like that, I cannot reboot the machine normally. 
> When attempting to unmount the network filesystems, the shutdown
> hangs, and I have to hard-reset the machine.
>  
> Is there anyone who could please help me to debug this problem?  As
> far as I know, I have NFS setup properly, but I don't know enough
> about it to know what options I might try.  I don't even care if the
> fix degrades performance; I just want it to not hang.
> 
> Does anyone have any ideas? 
>  
> Thanks very much in advance!
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

