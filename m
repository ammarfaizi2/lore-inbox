Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315616AbSFERSa>; Wed, 5 Jun 2002 13:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315619AbSFERS3>; Wed, 5 Jun 2002 13:18:29 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:15777 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S315616AbSFERS1>; Wed, 5 Jun 2002 13:18:27 -0400
Message-ID: <3CFE47D1.A4A3D0B4@nortelnetworks.com>
Date: Wed, 05 Jun 2002 13:18:09 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: packets being dropped in IP stack but no error counts incrementing?
In-Reply-To: <3CFD01F8.B69152E4@nortelnetworks.com> <3CFD9B9C.1050906@candelatech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> 
> I am not sure the UDP drop counters are available.  If you do
> find them, I'm interested in them too!

Well, I've found an entry in /proc that has some information.  The entry is:

/proc/net/softnet_stat


The first two columns are:

total
dropped


In this case, dropped is the number of messages dropped due to the softnet_data
queue being full.  I have actually hit this under high load.

I'm still looking for socket/protocol specific stuff though.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
