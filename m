Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267962AbUHKGf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267962AbUHKGf7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 02:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267963AbUHKGf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 02:35:59 -0400
Received: from web52907.mail.yahoo.com ([206.190.39.184]:6577 "HELO
	web52907.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267962AbUHKGf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 02:35:56 -0400
Message-ID: <20040811063556.44421.qmail@web52907.mail.yahoo.com>
Date: Wed, 11 Aug 2004 07:35:56 +0100 (BST)
From: =?iso-8859-1?q?Ankit=20Jain?= <ankitjain1580@yahoo.com>
Subject: problem with pointers in asm
To: gcc <gcc-help@gcc.gnu.org>
Cc: linux <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

well i want to understand how assembler treats
pointers?

my code is:

      1	#include<inttypes.h>
      2
      3
      4 int main()
      5 {
      6   uint8_t
a[8]={1,2,3,4,5,6,7,8},b[8]={0,0,0,0,0,0},i;
      7   uint8_t *m,*m1;
      8 
      9   m=a;
     10   m1=b;         //i have pointed m1 to b
     11   for(i=0;i<8;i++)
     12      printf("%d ",a[i]);
     13   printf("\n");
     14   asm("movq (%1), %%mm0 \n"
     15       "movq %%mm0, (%0) \n"
     16       :"=r"(m1)
     17       :"r"(m)
     18       );
     19 
     20   for(i=0;i<8;i++)
     21      printf("%d ",b[i]);
     22   return 0;
     23 }
well this problem is not solved yet. because when i
display b array then it prints all 0's. according to
me since i have initialised this m1 pointer then by b
then b whould have all the values which i have moved

some have advised me to use arrays here as constraint
but i want to use pointers. i am using r constraint
and it says it says that m1 will use a register (i
guess there is no problem in that)

what is the complete problem HOW THIS ASSEMBLER IS
TREATING THIS POINTER m1?

thanks 

ankit jain

________________________________________________________________________
Yahoo! Messenger - Communicate instantly..."Ping" 
your friends today! Download Messenger Now 
http://uk.messenger.yahoo.com/download/index.html
