Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267853AbTBYItE>; Tue, 25 Feb 2003 03:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267844AbTBYItE>; Tue, 25 Feb 2003 03:49:04 -0500
Received: from zeus.kernel.org ([204.152.189.113]:50907 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S267826AbTBYItC>;
	Tue, 25 Feb 2003 03:49:02 -0500
Message-ID: <014901c2dcab$dba77ba0$3002a8c0@yigitcan>
From: "Yigit Can" <yigit.can@karel.com.tr>
To: "linux c programming" <linux-c-programming@vger.kernel.org>,
       "linux kernel" <linux-kernel@vger.kernel.org>
Subject: getprotobyname failure
Date: Tue, 25 Feb 2003 10:57:00 +0200
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

I can run this program on my development machine=20
but when I try to run this program on my basic kernel it gives me the =
"memory fault" error.

I'm using libc-2.2.5 on a powerpc 8xx development kit
so, i'm using the same library on the host and target machine.

my development machine has celeron  type processor
and my target board is TQM850L (has ppc_850 processor).

I've replaced my protocols and nsswitch.conf files with host machines (my
protocols file contians "tcp 6 TCP" line)
and that's made no difference.

what can I do?
 
please help,
 

 my program :
 
#include <netdb.h>
#include <stdio.h>
 
 int main(void){
 
    struct sockaddr_in addr;
    struct protoent *protocol=3DNULL;
    protocol=3Dgetprotobyname("tcp");
    printf("\n RESULT : %02x \n",protocol->p_proto);
 
    return 0;
}

Yigit CAN
Karel Electronics Corp.
yigit.can@karel.com.tr

