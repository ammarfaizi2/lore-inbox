Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263968AbSJ3EBb>; Tue, 29 Oct 2002 23:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbSJ3EBb>; Tue, 29 Oct 2002 23:01:31 -0500
Received: from employees.nextframe.net ([212.169.100.200]:12029 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S263968AbSJ3EBa>; Tue, 29 Oct 2002 23:01:30 -0500
Date: Wed, 30 Oct 2002 05:19:45 +0100
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.45 - net/ipv4/syncookies.c] "structure has no member named `window'"
Message-ID: <20021030051945.D512@sexything>
Reply-To: morten.helgesen@nextframe.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, 

the one-liner below is needed to compile 2.5.45. 

please apply.

== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net


--- clean-linux-2.5.45/net/ipv4/syncookies.c    Wed Oct 30 02:28:17 2002
+++ patched-linux-2.5.45/net/ipv4/syncookies.c  Wed Oct 30 05:14:08 2002
@@ -189,7 +189,7 @@
        }

        /* Try to redo what tcp_v4_send_synack did. */
-       req->window_clamp = rt->u.dst.window;
+       req->window_clamp = dst_metric(&rt->u.dst, RTAX_WINDOW);
        tcp_select_initial_window(tcp_full_space(sk), req->mss,
                                  &req->rcv_wnd, &req->window_clamp,
                                  0, &rcv_wscale);

