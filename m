Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283464AbRK3CG6>; Thu, 29 Nov 2001 21:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283467AbRK3CGt>; Thu, 29 Nov 2001 21:06:49 -0500
Received: from [148.201.1.4] ([148.201.1.4]:31697 "EHLO iteso.mx")
	by vger.kernel.org with ESMTP id <S283464AbRK3CGd> convert rfc822-to-8bit;
	Thu, 29 Nov 2001 21:06:33 -0500
Date: Thu, 29 Nov 2001 20:06:30 -0600 (CST)
From: <jose@iteso.mx>
To: linux-kernel@vger.kernel.org
Subject: 32 bit UIDs on 2.4.14
Message-ID: <Pine.LNX.4.21.0111292002540.29568-100000@iteso.mx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi.

  What is the trick to get more than 2^16 uids working on all services??

  I'm using kernel 2.4.14, libc6 compiled with 2.4.7 headers, lib(pam|nss)-ldap
  openldap, wu-imap, cuci-pop, samba, telnet, ssh, Debian Potato.

  'id' and 'getent passwd high-uid-user' both return the right uid (which 
is stored on the ldap system), but 'ls -l' truncates the uid if it's higher than
65536 (say for uid  80000, it reports  14464), and sshd, telnetd and imapd deny
logins because setuid() invalidates a >16 bit interger as argument.

   What should I recompile??  is there a moderately easy workaround??



  Thanks



   José






