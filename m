Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136880AbREJSiC>; Thu, 10 May 2001 14:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136883AbREJShn>; Thu, 10 May 2001 14:37:43 -0400
Received: from fe000.worldonline.dk ([212.54.64.194]:23819 "HELO
	fe000.worldonline.dk") by vger.kernel.org with SMTP
	id <S136880AbREJShc>; Thu, 10 May 2001 14:37:32 -0400
Message-ID: <3AFAE18B.1010906@eisenstein.dk>
Date: Thu, 10 May 2001 20:44:27 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-mosix i586; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en, da
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mmap2 causes SIGBUS on 2.4.4-ac6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After compiling and installing a 2.4.4-ac6 kernel I noticed that some 
programs (notably 'grep') started crashing with 'Bus error's and 
captured some 'strace' output... In all cases the last four lines of 
output from strace are:

mmap2(0x8059000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0) = 0x8059000
mmap2(0x8059000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0xe00008) = 0x8059000
--- SIGBUS (Bus error) ---
+++ killed by SIGBUS +++

For those who would like to try and reproduce it, this command generates 
it every time:

$ grep foo /usr/src/linux/Documentation/*


So there seems to be some mmap related problem with 2.4.4-ac6. I tried 
running the exact same commands on a 2.2.17 and 2.2.19 and they do not 
exhibit this behaviour. I can try some more 2.4.x kernels if the 
information would be valuable?
If there is any other relevant information I can gather, then please let 
me know and I'll be happy to provide it.

I tried searching for "mmap2" and "SIGBUS" on 
http://www.uwsg.indiana.edu/hypermail/linux/kernel/ but could not find 
any posts related to this, so I thought it would be ok to post this.


Best regards,
Jesper Juhl - juhl@eisenstein.dk

