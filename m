Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263606AbTLXQkW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 11:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263647AbTLXQkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 11:40:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:53739 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263606AbTLXQkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 11:40:21 -0500
Date: Wed, 24 Dec 2003 08:35:40 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: sumit_uconn@lycos.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: undefined reference error
Message-Id: <20031224083540.40a04c0d.rddunlap@osdl.org>
In-Reply-To: <BCLLEMEMOFNOFJAA@mailcity.com>
References: <BCLLEMEMOFNOFJAA@mailcity.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Dec 2003 10:52:10 -0500 "Sumit Narayan" <sumit_uconn@lycos.com> wrote:

| Hi,
| 
| Pretty out of the place I am, and beg your pardon. I have modified my kernel 2.6.0 with few new functions in fs/kernthread.c, which required a header file linux/kernthread.h.
| 
| On compilation, I get this error:
| 
| fs/built-in.o(.text+0x242f1): In function 'stop_kernthread' :
|  : undefined reference to 'lock_kernel'
| make: ***[.tmp_vmlinux1] Error 1
| 
| Could someone help me out with this.
| Thanks in advance.

Add this line near the top of the source file, with the other
#include lines:

#include <linux/smp_lock.h>


--
~Randy
MOTD:  Always include version info.
