Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbSLOU1V>; Sun, 15 Dec 2002 15:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262472AbSLOU1V>; Sun, 15 Dec 2002 15:27:21 -0500
Received: from 4-090.ctame701-1.telepar.net.br ([200.193.162.90]:6850 "EHLO
	4-090.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262446AbSLOU1U>; Sun, 15 Dec 2002 15:27:20 -0500
Date: Sun, 15 Dec 2002 18:34:06 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: netdev@oss.sgi.com
cc: linux-kernel@vger.kernel.org
Subject: RFC:  p&p ipsec without authentication
Message-ID: <Pine.LNX.4.50L.0212151745360.2711-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got a crazy idea.  I know it's not secure, but I think it'll
add some security against certain attacks, while being non-effective
against some others.

The idea I have is letting the ipsec layer do opportunistic encryption
even when there are no ipsec keys known for the destination address,
ie. negotiate a key when none is in the configuration or DNS.

I know this gives absolutely no protection against man-in-the-middle
attacks (except maybe being able to detect them), but it should prevent
passive sniffing of network traffic, as done by some governments.

If this "random" encryption could be turned on with one argument to
ip or ifconfig and millions of hosts would use it, sniffing internet
traffic might just become impractical (or too expensive) for large
organisations.   Furthermore, even if just 0.1% of the hosts were to
use ipsec authentication, the 3-letter agencies would be faced with
the additional challenge of identifying which connections could safely
be intercepted with man-in-the-middle attacks and which couldn't.

Not to mention the fact that the port number on many communications
would be invisible, vastly increasing the difficulty of doing any
kind of statistical analysis on the traffic that's traversing the
network.

Is this idea completely crazy or only slightly ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
