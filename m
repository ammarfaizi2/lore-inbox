Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbUBWPuH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 10:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUBWPuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 10:50:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:59101 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261843AbUBWPuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 10:50:02 -0500
Date: Mon, 23 Feb 2004 07:42:21 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: mjl <malet.jean-luc@laposte.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [linux 2.6.3] [gcc 3.3.3] compile errors
Message-Id: <20040223074221.5f711665.rddunlap@osdl.org>
In-Reply-To: <403911B3.10601@laposte.net>
References: <403911B3.10601@laposte.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Feb 2004 21:31:47 +0100 mjl <malet.jean-luc@laposte.net> wrote:

| hello please cc me since I'm not a member
| all my builds fails with this error
| 
| In file included from ../include/swab.h:20,
|                  from ../include/misc.h:12,
|                  from io.c:21:
| /usr/include/linux/byteorder/swab.h:133: error: syntax error before "__u16"
| /usr/include/linux/byteorder/swab.h:146: error: syntax error before "__u32"

You are using userspace headers for building the kernel.
Maybe you have a symbolic link from linux/include/asm to the
userspace headers.  If so, Don't Do That.
In any case, don't use userspace headers to build the kernel.


| make[1]: *** [io.o] Error 1
| make[1]: Leaving directory `/usr/src/sorcery/reiserfsprogs-3.6.13/lib'
| make: *** [all-recursive] Error 1
| 
| 
| I looked into the source and  the line is
| 
| 
| static __inline__ __attribute_const__ __u16 __fswab16(__u16 x)
| {
| 
| 
| which don't looks bad ......



--
~Randy
