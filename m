Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278098AbRJKFHN>; Thu, 11 Oct 2001 01:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278096AbRJKFHF>; Thu, 11 Oct 2001 01:07:05 -0400
Received: from cti06.citenet.net ([206.123.38.70]:29963 "EHLO
	cti06.citenet.net") by vger.kernel.org with ESMTP
	id <S278097AbRJKFG5>; Thu, 11 Oct 2001 01:06:57 -0400
From: Jacques Gelinas <jack@solucorp.qc.ca>
Date: Thu, 11 Oct 2001 01:06:32 -0500
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Announce: many virtual servers on a single box
X-mailer: tlmpmail 0.1
Message-ID: <20011011010632.e0c6a94f1bc2@remtk.solucorp.qc.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have enhanced the kernel to allow several independant virtual servers
running on the same box (sharing the same kernel as well). I introduced
2 new system calls (new_s_context and set_ipv4root) allowing
much independance between the virtual servers. Virtual servers are
independant enough and "real" enough that you can supply root password
to the virtual server administrators. Virtual servers may be described

-May run various network services, binding to the same ports
 without special configuration. Services are started normally (sysv script, whatever
 the distro you are using).

-Have independant process list, so they can't interfere. You can't see or send
  signal to process in other vservers (or the root server)

-I have also modified the capability system a little, so those virtual server
 administrators can't take over the machine. I have introduced a per-process
 capability ceiling, inherited by sub-process. Even setuid program can't grab
 more capabilities..

-Update packages normally, create users, Use any admin procedure/tool

Maybe such a project has already been done. Anyway, I have written a lot
of documentation about it (how it works, pro and con and so on). It works
on top of 2.4.10 or 2.4.11 (probably anything). I would really like to get
some comments.

You can find all the documentation and packages at
http://www.solucorp.qc.ca/miscprj/s_context.hc

All this is GPL...

---------------------------------------------------------
Jacques Gelinas <jack@solucorp.qc.ca>
vserver: run general purpose virtual servers on one box, full speed!
http://www.solucorp.qc.ca/miscprj/s_context.hc
