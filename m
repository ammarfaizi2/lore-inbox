Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310949AbSCHQqG>; Fri, 8 Mar 2002 11:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310948AbSCHQpr>; Fri, 8 Mar 2002 11:45:47 -0500
Received: from courage.cs.stevens-tech.edu ([155.246.89.70]:10750 "HELO
	courage.cs.stevens-tech.edu") by vger.kernel.org with SMTP
	id <S310947AbSCHQpn>; Fri, 8 Mar 2002 11:45:43 -0500
Newsgroups: comp.os.linux.development.system
Date: Fri, 8 Mar 2002 11:45:30 -0500 (EST)
From: Marek Zawadzki <mzawadzk@cs.stevens-tech.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: simple -- who adds stuff to UDP hash?
Message-ID: <Pine.NEB.4.33.0203081139420.1845-100000@courage.cs.stevens-tech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody.

In 2.4.17 net/ipv4/udp.c there is a hash table defined:
struct sock *udp_hash[UDP_HTABLE_SIZE];

In my understanding it should contain all the allocated udp sockets (and
it does, since udp_v4_lookup is able to find one after a new packet
arrives).

_However_, I cannot find a single piece of code which would add a new
socket after it was created. Also, udp_v4_hash is a 'null' function.

Please let me know how new sockets are added to it -- I need it when I
create my own socket in "accept" (my code is based on UDP).

-marek

P.S. By sockets I mean 'struct sock'.

