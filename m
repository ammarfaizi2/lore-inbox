Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266816AbRGFTgC>; Fri, 6 Jul 2001 15:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266815AbRGFTfv>; Fri, 6 Jul 2001 15:35:51 -0400
Received: from h131s117a129n47.user.nortelnetworks.com ([47.129.117.131]:30851
	"HELO pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S266816AbRGFTfj>; Fri, 6 Jul 2001 15:35:39 -0400
Message-ID: <3B46130E.EB8A8A7C@nortelnetworks.com>
Date: Fri, 06 Jul 2001 15:35:42 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: root@chaos.analogic.com
Subject: Re: why this 1ms delay in mdio_read? (cont'd from "are ioctl calls 
 supposed to take this long?")
In-Reply-To: <Pine.LNX.3.95.1010706143953.5031A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Fri, 6 Jul 2001, Chris Friesen wrote:

> >       mdelay(1); /* One ms delay... */
> >
> >       ...rest of code...
> >
> 
> What? What kernel version?
> The code here says:
>      /* Establish sync by sending at least 32 logic ones */
>      for (i = 32; i >=0; i--) {..........}

I had assumed that it was part of the normal drivers, but now after digging into
it some more it appears to have been added as part of a patch from Motorola for
a compact PCI board.  I can't see why they would have done this but I'm trying
to track it down now.

Thanks for all your help,

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
