Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262626AbSIPQpf>; Mon, 16 Sep 2002 12:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262635AbSIPQpf>; Mon, 16 Sep 2002 12:45:35 -0400
Received: from 66.148.196.79.nw.nuvox.net ([66.148.196.79]:47503 "HELO
	greatwhite.teamics.com") by vger.kernel.org with SMTP
	id <S262626AbSIPQpf>; Mon, 16 Sep 2002 12:45:35 -0400
Subject: Problem:  RFC1166 addressing
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.6a  January 17, 2001
Message-ID: <OF298A60D6.2FD15C58-ON86256C36.005B260E@teamics.com>
From: tomc@teamics.com
Date: Mon, 16 Sep 2002 11:50:36 -0500
X-MIMETrack: Serialize by Router on greatwhite/teamics(Release 5.0.8 |June 18, 2001) at
 09/16/2002 11:50:37 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RFC 1166 states that:


 The class A network number 127 is assigned the "loopback"
         function, that is, a datagram sent by a higher level protocol
         to a network 127 address should loop back inside the host.  No
         datagram "sent" to a network 127 address should ever appear on
         any network anywhere.

 Linux does not enforce this.  I have uncovered some users using this
function to attempt to circumvent the firewall.  I am able to "create" 127
network traffic as follows:

Machine 1:   ifconfig eth0:1 127.1.2.3   [ running kernel 2.2.14 ]

Machine 2:   ifconfig eth0:1 127.1.2.4  [ running kernel 2.4.19 ]

Machine 2:  ping 127.1.2.3

Packets move between the hosts.    Also seems to work on Macintosh.





tc


