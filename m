Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261224AbSJUSWP>; Mon, 21 Oct 2002 14:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261447AbSJUSWP>; Mon, 21 Oct 2002 14:22:15 -0400
Received: from nameservices.net ([208.234.25.16]:51453 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S261224AbSJUSWO>;
	Mon, 21 Oct 2002 14:22:14 -0400
Message-ID: <3DB4487C.F6355C59@opersys.com>
Date: Mon, 21 Oct 2002 14:33:32 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: linux-kernel@vger.kernel.org, Jacques Gelinas <jack@solucorp.qc.ca>
Subject: Re: System call wrapping
References: <1035222121.1063.20.camel@pc177> <ap1g9a$pso$1@ncc1701.cistron.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Miquel van Smoorenburg wrote:
> In article <1035222121.1063.20.camel@pc177>,
> Henrý Þór Baldursson  <henry@f-prot.com> wrote:
> >In our Windows product we have something called "Realtime protector"
> >which monitors file access on Windows running machines and scans them
> >before allowing access.
> >
> >We now want, due to customer demand, to supply our Linux users with
> >similar functionality, and we've created a 2.4.x kernel module which
> >wrapped the open system call by means of overwriting
> >sys_call_table[__NR_open].
>
> What is wrong with a preloaded library (by means of /etc/ld.so.preload)
> that intercepts open at the library level (and calls the real open()
> using RLTD_NEXT) ? Just let it talk over a unix socket to your
> scanner server.

Jacques Gelinas already has something that does precisely that:
http://www.solucorp.qc.ca/virtualfs/

I don't know if it's still being updated, but the ideas are all there.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
