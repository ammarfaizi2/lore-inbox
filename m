Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274822AbRIZDoG>; Tue, 25 Sep 2001 23:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274823AbRIZDn5>; Tue, 25 Sep 2001 23:43:57 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:3254 "EHLO softhome.net")
	by vger.kernel.org with ESMTP id <S274822AbRIZDnj>;
	Tue, 25 Sep 2001 23:43:39 -0400
From: "John L. Males" <jlmales@softhome.net>
Organization: Toronto, Ontario, Canada
To: Mike Fedyk <mfedyk@matchmail.com>
Date: Tue, 25 Sep 2001 23:43:59 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re[07]: Linux Kernel 2.2.20-pre10 Initial Impressions
Reply-to: jlmales@softhome.net
CC: linux-kernel@vger.kernel.org
Message-ID: <3BB116BF.19313.7E42D8@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mike,

Thanks for your reply to my posting of test results.  I guess in the
future I had better keep placing at the start of my eMail note I am
not on the kernel mailing list.  therefore be appreciated if any
reply also copies me in as well.

Ok, you make a good point in your suggestion re:

You will probably see dns requests going out. You should check to
make sure that you are not blocking incomming udp ports (1024-5000
for bind, not sure about resolver...) as that would lengthen the
response time considerably if only a few are open, and completely
stop you if all are blocked. 


Although I would not of thought of that specifically, I did do a test
where I had no firewall or filtering started or in place previously. 
Yes, not how one should connect to the internet these days, but just
done for the purposes of the test and had a limited time window it
was done in.  So give that type of test, I really be interested in
your thoughts on how this point could be a factor.  I am not saying
it cannot be, as I really do not have enough knowledge in this area
to know.  The purpose of the test was to determine if either IPChains
or IPTables/Netfilter had any relationship to the delay.  Based on
the results I would think not, but again just my extremely limited
knowledge of the details of IP/TCP/UDP/DNS and kernel matters.

I will try the "tcpdump -qni ppp0" suggestion you made and see if it
help shed some light on the matter.  If the information is beyond my
understanding I will post it so you can look at it and offer your
analysis of the tcpdump information.

My schedule is a bit tight this week, so I may not get to the test
until the weekend if I do not have to work the weekend.  Failing that
I will try later in the week once my current assignment is complete,
or a week this weekend if the assignment I am on gets extended again
for a few days/week.

Again Mike thanks kindly for taking the time to reply and your
thoughts and observations.  You have given me a few more things to
chew on in my thoughts.  I will post any additional thoughts, tests
results, aor the solution if I determine it on my own.


Regards,

John L. Males
Willowdale, Ontario
Canada
25 September 2001 23:43
mailto:jlmales@softhome.net


=========================================================
=========================================================

From: Mike Fedyk (mfedyk@matchmail.com)
Date: Tue Sep 25 2001 - 04:41:57 EST 

     Next message: Daniel Phillips: "Re: Linux VM design" 
     Previous message: Alan Cox: "Re: Burning a CD image slow down my
connection" 
     Messages sorted by: [ date ] [ thread ] [ subject ] [ author ] 



On Sun, Sep 23, 2001 at 08:00:53PM -0500, John L. Males wrote: 
Content-Description: Mail message body 
> -----BEGIN PGP SIGNED MESSAGE----- 
> Hash: SHA1 
> 
> Hi Alan, 
> 
> Test Case One: 
> **************** 
> 
> - - Start Netscape 4.78 from desktop ICON 
> - - Click the pull down arrow on far right side of the "Go To:"
> (AKA  URL line) of Netscape 4.78. 
> 
> Results: 
> All were instant response from Netscape. Did the test for each 

> Test Case Two: 
> ***************** 
> 
> Steps used: 
> 
> - - Boot System 
> - - Log onto non-root user id. 
> - - "startx" (KDE desktop started) 
> (applications prestart from last log off include kppp, kpppload, 
> xosview, gnome terminal, khrono, 3 kfm's) 
> - - Had kppp "connect" to my ISP (dial up model 56KB, really 49,300
>  most of time, some connects 48,000, note kppp is configured to
> start  up ntpdate to sync with some time servers.) 
> - - Start Netscape 4.78 from desktop ICON 
> - - Click the pull down arrow on far right side of the "Go To:"
> (AKA  URL line) of Netscape 4.78. 
> 
> Results: 
> 
> For Kernel 2.2.19OWL, 2.2.20-pre10, 2.4.9-ac10 
> 
> All times were 2 minutes 3 seconds to get the URL list that appears
>   
> 
> 

> Test Case Three: 
> ******************* 
> 
> For the two times this test case was also done, still a delay of 2 
> minutes 3 seconds from the time clicked the button until the URLs 
> appeared. 

> Test Case Four: 
> ****************** 
> 
> For the one time I did this test case, a delay of 2 minutes 19 
> seconds from the time clicked the button until the URLs appeared. 
> 
> 

> Test Case Five: 
> ***************** 
> For Kernel 2.2.19OWL only was this test done. First time the delay 
> was 2 minutes 3 seconds, the second time it was 2 minutes 15
> seconds.   
> 
> 

I think you're right, it's not a kernel issue. You should run
"tcpdump -qni 
ppp0" in a xterm before you start netscape. 

You will probably see dns requests going out. You should check to
make sure 
that you are not blocking incomming udp ports (1024-5000 for bind,
not sure 
about resolver...) as that would lengthen the response time
considerably if 
only a few are open, and completely stop you if all are blocked. 

Mike 
- - 
To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in 
the body of a message to majordomo@vger.kernel.org 
More majordomo info at http://vger.kernel.org/majordomo-info.html 
Please read the FAQ at http://www.tux.org/lkml/ 



     Next message: Daniel Phillips: "Re: Linux VM design" 
     Previous message: Alan Cox: "Re: Burning a CD image slow down my
connection" 
     Messages sorted by: [ date ] [ thread ] [ subject ] [ author ] 



This archive was generated by hypermail 2b29 : Tue Sep 25 2001 -
21:00:15 EST 

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 6.5.8 for non-commercial use <http://www.pgp.com>

iQA/AwUBO7Fc6uAqzTDdanI2EQJcagCeKuKqtviLg7RHwwqxYZAzahZZfdoAn3mZ
RTrGXUQphk/o91ywxyNzRL5S
=Tbl/
-----END PGP SIGNATURE-----



"Boooomer ... Boom Boom, how are you Boom Boom" Boomer 1985 - February/2000
