Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261665AbSKCHaG>; Sun, 3 Nov 2002 02:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261669AbSKCHaG>; Sun, 3 Nov 2002 02:30:06 -0500
Received: from hacksaw.org ([216.41.5.170]:10233 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S261665AbSKCHaF>; Sun, 3 Nov 2002 02:30:05 -0500
Message-Id: <200211030736.gA37a2lv007213@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.5 08/15/2002 with nmh-1.0.4
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alexander Viro <viro@math.psu.edu>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6? 
In-reply-to: Your message of "Sat, 02 Nov 2002 19:35:25 PST."
             <Pine.LNX.4.44.0211021925230.2382-100000@home.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 03 Nov 2002 02:36:01 -0500
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A call from left field:

As a sys-admin I love the idea of the capabilities, but I hate this mount 
--bind thing. I'd really rather see it have its own command name. If it were 
strictly something that happens at mount time for a filesystem that'd be one 
thing, but

>mount --bind --capability=xx,yy /usr/bin/foo /usr/bin/foo

looks like a mistake. 

If you were loop mounting the binary into the user's directory, then I could 
see using mount.

This would be clearer:

setcap -c xx,yy /usr/bin/foo

(I also have nothing against long option names.)


-- 
The end is a finish, a conclusion or a completion.
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


