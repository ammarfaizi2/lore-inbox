Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261186AbSJUSKj>; Mon, 21 Oct 2002 14:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261191AbSJUSKj>; Mon, 21 Oct 2002 14:10:39 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:49158 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S261186AbSJUSKi>; Mon, 21 Oct 2002 14:10:38 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: System call wrapping
Date: Mon, 21 Oct 2002 18:16:10 +0000 (UTC)
Organization: Cistron
Message-ID: <ap1g9a$pso$1@ncc1701.cistron.net>
References: <1035222121.1063.20.camel@pc177>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1035224170 26520 62.216.29.67 (21 Oct 2002 18:16:10 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1035222121.1063.20.camel@pc177>,
Henrý Þór Baldursson  <henry@f-prot.com> wrote:
>In our Windows product we have something called "Realtime protector"
>which monitors file access on Windows running machines and scans them
>before allowing access. 
>
>We now want, due to customer demand, to supply our Linux users with
>similar functionality, and we've created a 2.4.x kernel module which
>wrapped the open system call by means of overwriting
>sys_call_table[__NR_open].

What is wrong with a preloaded library (by means of /etc/ld.so.preload)
that intercepts open at the library level (and calls the real open()
using RLTD_NEXT) ? Just let it talk over a unix socket to your
scanner server.

Mike.

