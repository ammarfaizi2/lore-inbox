Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319816AbSIMWkY>; Fri, 13 Sep 2002 18:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319817AbSIMWkX>; Fri, 13 Sep 2002 18:40:23 -0400
Received: from 2-028.ctame701-1.telepar.net.br ([200.193.160.28]:60058 "EHLO
	2-028.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S319816AbSIMWkW>; Fri, 13 Sep 2002 18:40:22 -0400
Date: Fri, 13 Sep 2002 19:44:56 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Timothy D. Witham" <wookie@osdl.org>
cc: jimsibley@earthlink.net, <linux-kernel@vger.kernel.org>,
       <thunder@lightweight.ods.org>
Subject: RE: Killing/balancing processes when overcommited
In-Reply-To: <1031956299.2317.240.camel@wookie-t23.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44L.0209131943390.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Sep 2002, Timothy D. Witham wrote:

>   In this case the offense is asking for more memory.  So it is the
> process that asks for more memory that goes away.  Again sometimes it
> will be an innocent bystander but hopefully it will eventually be the
> process that is causing the problem.

If you kill the process that requests memory, the sequence often
goes as follows:

1) memory is exhausted

2) the network driver can't allocate memory and
   spits out a message

3) syslogd and/or klogd get killed

Clearly you want to be a bit smarter about which process to kill.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

