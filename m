Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130125AbQKGWqY>; Tue, 7 Nov 2000 17:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130155AbQKGWqP>; Tue, 7 Nov 2000 17:46:15 -0500
Received: from omega.cisco.com ([171.69.63.141]:17589 "EHLO cisco.com")
	by vger.kernel.org with ESMTP id <S130125AbQKGWp5>;
	Tue, 7 Nov 2000 17:45:57 -0500
Message-Id: <4.3.2.7.2.20001107144236.02462f08@omega.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 07 Nov 2000 14:43:46 -0800
To: "David S. Miller" <davem@redhat.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
Cc: jordy@napster.com, linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
In-Reply-To: <200011070656.WAA02435@pizda.ninka.net>
In-Reply-To: <3A07A4B0.A7E9D62@napster.com>
 <3A07662F.39D711AE@napster.com>
 <200011070428.UAA01710@pizda.ninka.net>
 <3A079127.47B2B14C@napster.com>
 <200011070533.VAA02179@pizda.ninka.net>
 <3A079D83.2B46A8FD@napster.com>
 <200011070603.WAA02292@pizda.ninka.net>
 <3A07A4B0.A7E9D62@napster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>23:36:16.261533 64.124.41.179.8888 > 209.179.194.175.1084: P 1:21(20) ack 
>44 win 5840 (DF)
>23:36:16.261669 64.124.41.179.8888 > 209.179.194.175.1084: P 21:557(536) 
>ack 44 win 5840 (DF)
>23:36:19.261055 64.124.41.179.8888 > 209.179.194.175.1084: P 1:21(20) ack 
>44 win 5840 (DF)
>
>The equivalent packets from the win98 log:
>
>22:34:36.069773 64.124.41.179.8888 > 209.179.194.175.1084: P 1:19(18) ack 
>44 win 5840 (DF)
>22:34:36.069837 64.124.41.179.8888 > 209.179.194.175.1084: P 19:553(534) 
>ack 44 win 5840 (DF)
>22:34:39.049788 64.124.41.179.8888 > 209.179.194.175.1084: P 1:21(20) ack 
>44 win 5840 (DF)
>
>(ie. Linux sends bytes 1:21 both the first time, and when it
>  retransmits that data.  However win98 "sees" this as 1:19 the first
>  time and 1:21 during the retransmit by Linux)

this excerpt looks like when a modem is set to eat XON/XOFF ...

a ping which does a sweep of many byte values should show this up ...


cheers,

lincoln.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
