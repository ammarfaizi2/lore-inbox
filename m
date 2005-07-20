Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVGTW5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVGTW5g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 18:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVGTW5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 18:57:36 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:65181 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261519AbVGTW5g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 18:57:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qmwWAQWJplKj3QmYhsyDB1OdI/id2N37yUAblng39zWOTKsX6dZJmYGsAMCEzj1MDjSoMOlnnTxXXcO/2NG98XCUNpYB0tOA1iwlOO83qx5o/eHp/OMOOvdJ7QKvgj+A4lwiCiCVrUbm6LyTaTFUi5BGYe7zjMVJo4BpaoumJrU=
Message-ID: <9871ee5f050720155671cbc376@mail.gmail.com>
Date: Wed, 20 Jul 2005 18:56:59 -0400
From: Timothy Miller <theosib@gmail.com>
Reply-To: Timothy Miller <theosib@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: HELP: NFS mount hangs when attempting to copy file
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My research suggests that NFS client mounting is kernel-based, so
that's why I'm posting here.  If there's a more appropriate list to
post to, I apologise, but I am not a list member.

I'm having a bit of a problem doing simple copies over an NFS mount. 
The client is running Linux (2.6.11), and the server is running
Solaris (5.8).

When I first boot the client, getting NFS directory listings works
just fine.  But the instant I try to copy a file (to or from), the NFS
mount hangs.  While I can still do other network activity (even rlogin
to the server), any NFS access I try to do after that point hangs,
including directory listings.

I have had this same client and server working flawlessly for years. 
The only change is that the client is now on a VPN (Watchguard SOHO
box).  However, I have a Sun machine on the same VPN network segment,
and it can copy files with no problem, so it's not the router/SOHO
that's blocking anything.  (NIS and DNS also work just fine for both
machines.)

Also, after it hangs like that, I cannot reboot the machine normally. 
When attempting to unmount the network filesystems, the shutdown
hangs, and I have to hard-reset the machine.
 
Is there anyone who could please help me to debug this problem?  As
far as I know, I have NFS setup properly, but I don't know enough
about it to know what options I might try.  I don't even care if the
fix degrades performance; I just want it to not hang.

Does anyone have any ideas? 
 
Thanks very much in advance!
