Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264950AbSKVPSp>; Fri, 22 Nov 2002 10:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbSKVPSp>; Fri, 22 Nov 2002 10:18:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2573 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id <S264950AbSKVPSo>;
	Fri, 22 Nov 2002 10:18:44 -0500
Date: Fri, 22 Nov 2002 09:25:49 -0600
From: Tommy Reynolds <reynolds@redhat.com>
To: paul_wu@wnexus.com.tw
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which embedded linux is better for being a router? eCos? uclinux?
Message-Id: <20021122092549.29697fa3.reynolds@redhat.com>
In-Reply-To: <48256C79.00188FF3.00@TWHSZDS1.WISTRON.COM.TW>
References: <48256C79.00188FF3.00@TWHSZDS1.WISTRON.COM.TW>
Organization: Red Hat Software, Inc. / Global Learning Services
X-Mailer: Sylpheed version 0.8.6cvs5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Overcoming an impressive lethardy, paul_wu@wnexus.com.tw mumbled:

>  Try to make a router running a embedded linux OS, but don't know select which
>  one is better, eCos? uclinux?
>  Does anyone have such experiences?

By far the easiest solution is to use ordinary Linux on a really old,
cheap PC, or a PC-on-a-board.

eCos can be built with the smallest memory and resource footprint of
any of the other techniques, but may not already support the Ethernet
cards or other devices you need: eCos just doesn't have the sheer
number of device drivers as does Linux.

uCLinux would work well enough, as it's intended for cheap-as-dirt
CPU's that lack an MMU. The features it lacks (there is no "fork()"
only "vfork()") can be easily worked around but your application
software may need tweaking.

Without knowing your engineering requirements it is impossible to say
what you need.
