Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292511AbSB0QXM>; Wed, 27 Feb 2002 11:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292761AbSB0QW4>; Wed, 27 Feb 2002 11:22:56 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:42375 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S292708AbSB0QWo>; Wed, 27 Feb 2002 11:22:44 -0500
Message-ID: <3C7D09C1.62BFB539@nortelnetworks.com>
Date: Wed, 27 Feb 2002 11:30:57 -0500
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [BETA] First test release of Tigon3 driver
In-Reply-To: <20020227125611.A20415@stud.ntnu.no> <20020227.040653.58455636.davem@redhat.com> <20020227132454.B24996@stud.ntnu.no> <20020227.042845.54186884.davem@redhat.com> <20020227170321.B22422@stud.ntnu.no>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Langås wrote:
> 
> David S. Miller:
> > At this point I'm mostly interested in if it works at all :-)
> > If the answer is yes, tell me that and then you can feel
> > free to experiment with jumbo frames et al. to discover
> > other bugs in the driver :-)
> 
> Just tested with MTU set at 1500 for now, but it seems to work fine, did a
> netcat between two boxes on the same switch and got around 80MB/sec.
> 
> Any programs or anything that could do a serious stresstest?  (Both hosts
> are Dell PowerEdge 2550, RedHat Linux 7.2).

I've had good luck with an infinite loop on sendto().  Can easily saturate a
link, and depending on the receiving host, can essentially DOS the machine.

As an example, a Dell OptiPlex GX1 running 2.4.17 becomes completely unusable
when receiving 80000 packets/sec.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
