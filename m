Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262728AbSIPR2y>; Mon, 16 Sep 2002 13:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262747AbSIPR2y>; Mon, 16 Sep 2002 13:28:54 -0400
Received: from 66.148.196.79.nw.nuvox.net ([66.148.196.79]:59023 "HELO
	greatwhite.teamics.com") by vger.kernel.org with SMTP
	id <S262728AbSIPR2x>; Mon, 16 Sep 2002 13:28:53 -0400
Subject: Re: Problem:  RFC1166 addressing
To: Gerhard Mack <gmack@innerfire.net>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.6a  January 17, 2001
Message-ID: <OFE0F05D6B.6256F71D-ON86256C36.006060FE@teamics.com>
From: tomc@teamics.com
Date: Mon, 16 Sep 2002 12:33:54 -0500
X-MIMETrack: Serialize by Router on greatwhite/teamics(Release 5.0.8 |June 18, 2001) at
 09/16/2002 12:33:55 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You are correct sir.   I was just quite surprised to find that it works,
and that I can reassign the 127 network to any interface I like.

tc


                                                                                                                
                    Gerhard Mack                                                                                
                    <gmack@innerfi       To:     tomc@teamics.com                                               
                    re.net>              cc:     linux-kernel@vger.kernel.org                                   
                                         Subject:     Re: Problem:  RFC1166 addressing                          
                    09/16/02 12:25                                                                              
                    PM                                                                                          
                                                                                                                
                                                                                                                




On Mon, 16 Sep 2002 tomc@teamics.com wrote:

> Date: Mon, 16 Sep 2002 11:50:36 -0500
> From: tomc@teamics.com
> To: linux-kernel@vger.kernel.org
> Subject: Problem:  RFC1166 addressing
>
> RFC 1166 states that:
>
>
>  The class A network number 127 is assigned the "loopback"
>          function, that is, a datagram sent by a higher level protocol
>          to a network 127 address should loop back inside the host.  No
>          datagram "sent" to a network 127 address should ever appear on
>          any network anywhere.
>
>  Linux does not enforce this.  I have uncovered some users using this
> function to attempt to circumvent the firewall.  I am able to "create"
127
> network traffic as follows:
>
> Machine 1:   ifconfig eth0:1 127.1.2.3   [ running kernel 2.2.14 ]
>
> Machine 2:   ifconfig eth0:1 127.1.2.4  [ running kernel 2.4.19 ]
>
> Machine 2:  ping 127.1.2.3
>
> Packets move between the hosts.    Also seems to work on Macintosh.


I would call that a bug in the firewall rules.  Depending on the hosts to
behave in such a way as to make life easier for the firewall makes for a
losing proposition.

     Gerhard


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.




