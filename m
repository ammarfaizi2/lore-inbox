Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129426AbQLACgM>; Thu, 30 Nov 2000 21:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129525AbQLACgC>; Thu, 30 Nov 2000 21:36:02 -0500
Received: from trgras.timpanogas.org ([207.109.151.236]:4 "EHLO
	trgras.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129426AbQLACfo>; Thu, 30 Nov 2000 21:35:44 -0500
Date: Thu, 30 Nov 2000 18:59:26 -0700
From: root <root@trgras.timpanogas.org>
To: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Oops in 2.2.18 with pppd dial in server
Message-ID: <20001130185926.A884@trgras.timpanogas.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii


Alan,

I was able to reproduce this oops with a somewhat more reliable ksymoops (I was ready for this nasty bug this time).  Looks like the problem is in the sockets
code.

See attached.

Jeff

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.txt"

ksymoops 0.7c on i686 2.2.18pre21.  Options used
EIP:  0010: [<c013365d>]
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace: [<c014c43d>] [<c014cb15>] [<c012d79a>] [<c012dda8>] [<c014cb82>] [<c014d7cb>] [<c010a038>]
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; c013365d <get_empty_inode+15/98>   <=====
Trace; c014c43d <get_fd+91/9c>
Trace; c014cb15 <sock_create+85/d8>
Trace; c012d79a <permission+1a/2c>
Trace; c012dda8 <open_namei+1dc/34c>
Trace; c014cb82 <sys_socket+1a/7c>
Trace; c014d7cb <sys_socketcall+5f/1a8>
Trace; c010a038 <system_call+34/38>



--RnlQjJ0d97Da+TV1--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
