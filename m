Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262397AbTCMPXG>; Thu, 13 Mar 2003 10:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262401AbTCMPXG>; Thu, 13 Mar 2003 10:23:06 -0500
Received: from pa186.opole.sdi.tpnet.pl ([213.76.204.186]:47098 "EHLO
	deimos.one.pl") by vger.kernel.org with ESMTP id <S262397AbTCMPXF> convert rfc822-to-8bit;
	Thu, 13 Mar 2003 10:23:05 -0500
Date: Thu, 13 Mar 2003 16:33:44 +0100
From: Damian =?iso-8859-2?Q?Ko=B3kowski?= <deimos@deimos.one.pl>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, James Stevenson <james@stev.org>,
       pd dd <parviz_kernel@yahoo.com>,
       "M. Soltysiak" <msoltysiak@hotmail.com>,
       William Stearns <wstearns@pobox.com>,
       ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux BUG: Memory Leak
Message-ID: <20030313153344.GA1902@deimos.one.pl>
References: <20030313091315.14044.qmail@web20504.mail.yahoo.com> <01f801c2e96c$980b4390$0cfea8c0@ezdsp.com> <1047570333.25944.42.camel@irongate.swansea.linux.org.uk> <20030313150544.GC5488@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20030313150544.GC5488@louise.pinerecords.com>
User-Agent: Mutt/1.4i
X-GPG: http://deimos.one.pl/deimos.asc
X-Age: 23 (1980.09.27 - lilbra)
X-JID: deimos@jabber.gda.pl
X-ICQ: 59367544
X-GG: 88988
X-Girl: 1 will be enough!
X-OS: GNU/Linux-2.4.20-ac2-dk1 (i686)
X-Uptime: 16:16:24 up  2:53,  4 users,  load average: 1.00, 1.00, 0.90
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tomas Szepe (szepe@pinerecords.com) wrote:
> As far as I can tell, DRM has worked nicely with both 8.1 and 9.0-rc[12].

Not on every hardware!

For example:
- X: 4.3.0 (slackware-current)
- mainboard_chipset: via-kt-400
- g.card: ATI Radeon 9000 (rv250If)
- kernel: 2.4.21-pre5-acX & 2.4.20-ac2 -> DRM 1.{6|7|8}.0 (from -ac - DRM-7)
- DRI, DRM:
	dri.sf.net,
	http://www.xfree86.org/~alanh/,
	http://cpbotha.net/dri_resume.html,
	etc...

Don't work with OpenGL (hardware acceleration) like it was in _fglrx_
(ATI-2.5.1 binary driver for X-4.{1|2}.x).

.~. $ dmesg | grep drm
[drm] AGP 0.99 on VIA Apollo KT400 @ 0xd0000000 128MB
[drm] Initialized radeon 1.7.0 20020828 on minor 0
.~. $ dmesg | grep radeonfb
radeonfb: ref_clk=2700, ref_div=12, xclk=20000 from BIOS
radeonfb: MTRR enabled
radeonfb: ATI Radeon 9000 If  DDR SGRAM 64 MB
radeonfb: DVI port no monitor connected
radeonfb: CRT port CRT monitor connected
.~. $

Simple test, tray to run ut2003-demo ;-)

P.S. On debian-sid, with SiS mainboard chipset it works in X-4.3.0 (but not so
fine like on binary _fglrx_) :-(

-- 
# Damian *dEiMoS* Ko³kowski # http://deimos.one.pl/ #
