Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266898AbSL3LUW>; Mon, 30 Dec 2002 06:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbSL3LUV>; Mon, 30 Dec 2002 06:20:21 -0500
Received: from pusa.informat.uv.es ([147.156.10.98]:13711 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP
	id <S266898AbSL3LUR>; Mon, 30 Dec 2002 06:20:17 -0500
Date: Mon, 30 Dec 2002 12:28:38 +0100
To: linux-kernel@vger.kernel.org
Subject: How much we can trust packet timestamping
Message-ID: <20021230112838.GA928@pusa.informat.uv.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: uaca@alumni.uv.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

IMHO The problem is quite complicated because

+ common hardware is not designed for real time:

	- sends multiple PDUs within one interrupt, and can be delayed
	- Host adapter bus & infraestructure is not designed to garantee latency
  	etc...
     
+ software is also not designed for realtime

	- drivers may timestamp in softirq's
	- irqs has no deterministic latency either
	etc...

So even if do_gettimeofday() has 1/CPUfreq resolution by using TSC register
packet timestamping meassurement is biased, how much?

anybody has studied this? are there reports/doc about this topic?

of course, this can be avoided by using specialiced hardware, but I'm not
interested on that and I would like to know how much I can trust this
timestamps

Any comment would be greatly appreciated

Thanks

	Ulisses

                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---
