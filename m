Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261246AbTDBBIS>; Tue, 1 Apr 2003 20:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261281AbTDBBIS>; Tue, 1 Apr 2003 20:08:18 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.10]:37903 "EHLO
	net.cc.swin.edu.au") by vger.kernel.org with ESMTP
	id <S261246AbTDBBIR>; Tue, 1 Apr 2003 20:08:17 -0500
Date: Wed, 2 Apr 2003 11:19:39 +1000 (EST)
From: Tim Connors <tconnors@astro.swin.edu.au>
X-X-Sender: <tconnors@tellurium.ssi.swin.edu.au>
To: <174521@bugs.debian.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: threads leave zombies when they terminate
Message-ID: <Pine.LNX.4.33.0304021113530.28106-100000@tellurium.ssi.swin.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CC'd to linux-kernel, so as to get comments on my last paragraph.

I can confirm noflushd as being the cause of the problem, as per

http://groups.google.com/groups?q=noflushd+ext3+zombies&hl=en&lr=lang_da|lang_nl|lang_en|lang_fr|lang_de|lang_el|lang_iw|lang_it|lang_ru|lang_tr&ie=UTF-8&oe=UTF-8&safe=off&selm=20030328204021%242645%40gated-at.bofh.it&rnum=1


I am also wondering whether it only applies to systems with an ext3
partition? I say this because I don't recall the bug appearing before I
upgraded, although I possibly did install ext3 at the same time as
noflushd - upgrades all seem to happen at once :)

What I think (random stab in the dark), is the killing of a kernel thread
- kupdate[d] is the problem. Just how safe is it to kill -STOP a kernel
thread? Could this be causing all -lpthreaded apps to leave zombies
behind?

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/

A debugged program is one for which you have not yet found the
conditions that make it fail.
                -- Jerry Ogdin

