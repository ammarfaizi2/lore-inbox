Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132709AbRDNCXU>; Fri, 13 Apr 2001 22:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132724AbRDNCXK>; Fri, 13 Apr 2001 22:23:10 -0400
Received: from tisch.mail.mindspring.net ([207.69.200.157]:19242 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S132709AbRDNCXE>; Fri, 13 Apr 2001 22:23:04 -0400
Message-ID: <3AD78A6C.F0F3CF5A@mindspring.com>
Date: Fri, 13 Apr 2001 19:23:24 -0400
From: Joe <joeja@mindspring.com>
Reply-To: joeja@mindspring.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bug in float on Pentium
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure but I think I found a NEW bug.

I know that there have been some issues with pentiums and floating point
arrithmatic, but this takes the cake...

Linux Lserver.org 2.2.18 #43 SMP Fri Mar 9 14:19:41 EST 2001 i586
unknown

>kgcc --version
egcs-2.91.66

RH 6.2.x / 7.0

try this program

#include <stdio.h>

int main() {

    char tmpx[100];
 char tmpy[100];

 double x = 5483.99;
 float y = 5483.99;

    sprintf (tmpx, "%f",x );
    sprintf (tmpy, "%f",y );

 printf ("%s\n%s\n", tmpx, tmpy);
 return 0;
}


I am getting the following as output

joeja@Lserver$ ./testf
5483.990000
5483.990234


what is with the .990234??  it should be .990000

any ideas on this??

--
Joe Acosta ........
home: joeja@mindspring.com



