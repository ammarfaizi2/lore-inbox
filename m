Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315212AbSDWOAl>; Tue, 23 Apr 2002 10:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315214AbSDWOAl>; Tue, 23 Apr 2002 10:00:41 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:36579 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S315212AbSDWOAj>; Tue, 23 Apr 2002 10:00:39 -0400
Message-ID: <3CC55D62.1501C94A@nortelnetworks.com>
Date: Tue, 23 Apr 2002 09:10:58 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank Louwers <frank@openminds.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2 NICs on same network
In-Reply-To: <20020423113935.A30329@openminds.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Louwers wrote:
> 
> Hi,
> 
> We recently stummed across a rather annoying bug when 2 nics are on
> the same network.
> 
> Our situation is this: we have a server with 2 nics, each with a
> different IP on the same network, connected to the same switch. Let's
> assume eth0 has ip 1.2.3.1 and eth1 has 1.2.3.2, with a both with a
> netmask of 255.255.255.0.
> 
> Now the strange thing is that traffic for 1.2.3.2 arrives at eth0 no
> matter what!


This is actually standards compliant behaviour, as silly as it sounds.  However,
if you want stricter arp behaviour I *think* that the following will fix it.  At
least it used to...


echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter


If this is no longer correct I'd love to hear it.

Chris


Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
