Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268625AbTBZMsq>; Wed, 26 Feb 2003 07:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268738AbTBZMsq>; Wed, 26 Feb 2003 07:48:46 -0500
Received: from [195.214.178.133] ([195.214.178.133]:49010 "EHLO octopus")
	by vger.kernel.org with ESMTP id <S268625AbTBZMsm>;
	Wed, 26 Feb 2003 07:48:42 -0500
Message-ID: <001d01c2dd96$eac076f0$3002a8c0@yigitcan>
From: "Yigit Can" <yigit.can@karel.com.tr>
To: "kernelnewbies" <kernelnewbies@nl.linux.org>,
       "linux kernel" <linux-kernel@vger.kernel.org>,
       "linux config" <linux-config@vger.kernel.org>,
       "linux c programming" <linux-c-programming@vger.kernel.org>
Subject: getprotobyname failure
Date: Wed, 26 Feb 2003 14:59:28 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-9"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a problem with getprotobyname() function.

I wrote a simple program that only uses getprotobyname function

I can run this program on my development machine
but when I try to run this program on my basic kernel it gives me the
"memory fault" error.

the "getprotobyname" function returns NULL and i don't know the reason,
becouse i have the /etc/protocols file containing "tcp 6 TCP" line

I'm using Denx embedded linux development kit with libc-2.2.5 with an cross
compiler

my development machine has celeron  type processor
and my target board is TQM850L (powerpc 850)

I've replaced my protocols and nsswitch.conf files with host machines (my
protocols file contians "tcp 6 TCP" line)
and that's made no difference.

Why the getprotobyname function returns NULL?

please help,


 my program :

#include <netdb.h>
#include <stdio.h>

 int main(void){

    struct sockaddr_in addr;
    struct protoent *protocol=NULL;
    protocol=getprotobyname("tcp");
    printf("\n RESULT : %02x \n",protocol->p_proto);

    return 0;
}

Yigit CAN



