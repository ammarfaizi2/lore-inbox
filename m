Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129679AbRC3BAI>; Thu, 29 Mar 2001 20:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129712AbRC3A76>; Thu, 29 Mar 2001 19:59:58 -0500
Received: from web5204.mail.yahoo.com ([216.115.106.85]:44043 "HELO
	web5204.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129679AbRC3A7o>; Thu, 29 Mar 2001 19:59:44 -0500
Message-ID: <20010330005903.2800.qmail@web5204.mail.yahoo.com>
Date: Thu, 29 Mar 2001 16:59:03 -0800 (PST)
From: Rob Landley <telomerase@yahoo.com>
Subject: Original destination of transparent proxied connections?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Help.

I thought transparent proxying would allow some means
for the recipient of the proxied connections to find
out what their original destination port and socket
address were.  This does not seem to be the case.  The
socket structure only has one address and one socket,
and those have the source address, not the destination
address.

How do forward connections to a given address range to
a user space program that then has the opportunity to
bidirectionally munge the data in them and forward
them on?  Transparent proxying works just fine
assuming I only ever want to forward a single port to
just one other machine...

IPCHAINS isn't up to it.  Before I go and upgrade to
the 2.4 kernel on production systems that ship Real
Soon Now, could somebody give me at least an opinion
on whether or not iptables and the 2.4 nat stuff can
do this kind of thing without me having to modify the
kernel to fill out a larger socket-oid structure?  (Is
2.4 iptables documented anywhere yet?)

I've got everything else.  If I could just get a
destination address and port out of transparently
proxied connections I'd be home free.  I'm amazed this
data isn't there already, I must have missed something
stupid.  How do sockets bound to multiple interfaces
figure out which interface the connection came from?

Rob

__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/?.refer=text
