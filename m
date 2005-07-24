Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVGXTMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVGXTMV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 15:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVGXTMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 15:12:20 -0400
Received: from web53608.mail.yahoo.com ([206.190.37.41]:37772 "HELO
	web53608.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261456AbVGXTMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 15:12:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ekxBA98YHRF/xxJWTgkKnuOxn7G1rRiZ6Cbx0izh2JYHi8l3/Pk8sA75kEQ1e+cM8GsDt4DQvijJLqltO5R+uN2XOGX33qHLWNEoudvJyv4tkcXEZoczWdWOM2VUAbX9d2tfMGpV/72X4bbi5TB3l7jPD4ZbsJbI1SpuCXO29XE=  ;
Message-ID: <20050724191211.48495.qmail@web53608.mail.yahoo.com>
Date: Sun, 24 Jul 2005 12:12:11 -0700 (PDT)
From: Ciprian <cipicip@yahoo.com>
Subject: kernel 2.6 speed
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys!

I got a question for you. Apparently kernel 2.6 is
much slower then 2.4 and about 30 times slower then
the windows one.

I'm not an OS guru, but I ran a little and very simple
test. The program bellow, as you can see, measures the
number of cycles performed in 30 seconds.

//----------------- START CODE --------------------

#include <stdio.h>
#include <time.h>


int main()
{
time_t initialTime;
time_t testTime;
long counter = 0;
double test = 1;


time(&initialTime);
testTime = initialTime;

printf("Here we go...\n");

while((testTime-initialTime) < 30)
{
time(&testTime);
test /= 10;
test *= 10;
test += 10;
test -= 10;

counter ++;

}

printf("No. of cycles: %ld\n", counter);

return 0;
}

//---------------- END CODE -------------------


In windows were performed about 300 millions cycles,
while in Linux about 10 millions. This test was run on
Fedora 4 and Suse 9.2 as Linux machines, and Windows
XP Pro with VS .Net 2003 on the MS side. My CPU is a
P4 @3GHz HT 800MHz bus.

I published my little test on several forums and I
wasn't the only one who got these results. All the
other users using 2.6 kernel obtained similar results
regardless of the CPU they had (Intel or AMD). 

Also I downloaded the latest kernel (2.6.12),
configured it specifically for my machine, disabled
all the modules I don't need and compiled it. The
result was a 1.7 MB kernel on which KDE moves faster,
but the processing speed it's the same - same huge
speed ratios.

Also, it shouldn't have any importance, but my HDD is
SATA so the specific modules were required. I don't
think its SCSI modules have any impact on the
processing speed, but you know more on the kernel
architecture then I do.

Now, can anyone explain this and suggest what other
optimizations I should use? The 2.4 version was a lot
faster. I thought the newer versions were supposed to
work faster (or at least just as fast) AND to offer
extra features.

Any help would appreciate.

Thanks,
Ciprian



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
