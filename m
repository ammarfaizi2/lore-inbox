Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129232AbRCBPNE>; Fri, 2 Mar 2001 10:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129227AbRCBPMy>; Fri, 2 Mar 2001 10:12:54 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:29408 "EHLO
	zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S129232AbRCBPMs>; Fri, 2 Mar 2001 10:12:48 -0500
Message-ID: <3A9FB760.15E6321F@nortelnetworks.com>
Date: Fri, 02 Mar 2001 10:08:17 -0500
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; HP-UX B.10.20 9000/778)
X-Accept-Language: en
MIME-Version: 1.0
To: John Being <olonho@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: strange nonmonotonic behavior of gettimeoftheday -- seen similar 
         problem on PPC
In-Reply-To: <F104TJcu8Puwo7hGP4E00009f3d@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Being wrote:

> gives following result on box in question
> root@******:# ./clo
> Leap found: -1687 msec
> and prints nothing on all other  my boxes.
> This gives me bunch of troubles with occasional hang ups and I found nothing
> in kernel archives at
> http://www.uwsg.indiana.edu/hypermail/linux/kernel/index.html
> just some notes about smth like this for SMP boxes with ntp. Is this issue
> known, and how can I fix it?

I've run into non-monotonic gettimeofday() on a PPC system with 2.2.17, but it
always seemed to be almost exactly a jiffy out, as though it was getting
hundredths of a second from the old tick, and microseconds from the new tick. 
Your leap seems to be more unusual, and the first one I've seen on an x86 box.

Have you considered storing the results to see what happens on the next call? 
Does it make up the difference, or do you just lose that time?

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
