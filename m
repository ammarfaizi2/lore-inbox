Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265146AbRFZWzo>; Tue, 26 Jun 2001 18:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265148AbRFZWzh>; Tue, 26 Jun 2001 18:55:37 -0400
Received: from web14805.mail.yahoo.com ([216.136.224.221]:55812 "HELO
	web14805.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S265146AbRFZWza>; Tue, 26 Jun 2001 18:55:30 -0400
Message-ID: <20010626225415.26347.qmail@web14805.mail.yahoo.com>
Date: Tue, 26 Jun 2001 15:54:15 -0700 (PDT)
From: siva kumar <mobi_linux@yahoo.com>
Subject: Regrading signal/sigaction.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is it possible to pass any local variable as an
argument in the signal handler function.Basically I
want to print the value of the local variable in the
signal handler function.

In the below program I want to print the value of a in
the timeout function(siganl handler), whenever the
Alaram signal send.


Your comment are welcomed.

My prototype code is:

#include<stdio.h>
#include<signal.h>
void timeout(int signo,int a)
{
        printf ("timeout");
        printf("the value is %d and %d",signo,a);
}
 
main()
{
        int a =5;
        struct sigaction act,oact;
        act.sa_handler = timeout;
        sigemptyset(&act.sa_mask);
        act.sa_flags = 0;
        sigaction(SIGALRM, &act, &oact);
 
        alarm(10);
        sleep(10);
 
}

Thanks,
siva.s


__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail - only $35 
a year!  http://personal.mail.yahoo.com/
