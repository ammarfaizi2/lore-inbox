Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281047AbRKUN2w>; Wed, 21 Nov 2001 08:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281028AbRKUN2m>; Wed, 21 Nov 2001 08:28:42 -0500
Received: from bbnrel4.hp.com ([155.208.254.68]:33297 "HELO
	bbnrel4.net.external.hp.com") by vger.kernel.org with SMTP
	id <S280998AbRKUN23>; Wed, 21 Nov 2001 08:28:29 -0500
Message-ID: <3BFBABFA.9040200@hp.com>
Date: Wed, 21 Nov 2001 14:28:26 +0100
From: Francois-Xavier KOWALSKI <francois-xavier_kowalski@hp.com>
Reply-To: francois-xavier_kowalski@hp.com
Organization: HP
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux-Kernel Mailing-List <linux-kernel@vger.kernel.org>
Subject: [2.4.14] wrong IPv4 listen syscall return code
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel developpers,

(please Cc: me in reply, since I am not on the ML).

I am puzzled my a problem around the listen(2) system call.

The man page states the following item, which make sense:

ERRORS
       EADDRINUSE
              Another socket is already  listening  on  the  same
              port.

       EBADF  The argument s is not a valid descriptor.

       ENOTSOCK
              The argument s is not a socket.

       EOPNOTSUPP
              The  socket is not of a type that supports the lis­
              ten operation.

But when I go within the source code of listen implementation for STREAM 
protocol (as specified for TCL in net/ipv4/af_inet.c) in the function 
inet_listen() the default return code is EINVAL instead of EOPNOTSUPP.

Who holds the truth? I believe source code is wrong, since EOPNOTSUPP is 
much more explicit.

BTW, where is the official & as much up-to-date as possible source for 
kernel syscalls man pages?

-- 
Francois-Xavier "FiX" KOWALSKI


