Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWG0DXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWG0DXY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 23:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWG0DXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 23:23:24 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:26596 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751231AbWG0DXX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 23:23:23 -0400
Message-ID: <1153970545.44c8317195470@portal.student.luth.se>
Date: Thu, 27 Jul 2006 05:22:25 +0200
From: ricknu-0@student.ltu.se
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, larsbj@gullik.net,
       Paul Jackson <pj@sgi.com>
Subject: Re: [RFC][PATCH] A generic boolean (version 6)
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153945705.44c7d069c5e18@portal.student.luth.se> <200607270448.03257.arnd.bergmann@de.ibm.com>
In-Reply-To: <200607270448.03257.arnd.bergmann@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Citerar Arnd Bergmann <arnd.bergmann@de.ibm.com>:

> On Wednesday 26 July 2006 22:28, ricknu-0@student.ltu.se wrote:
> > Have not found any (real) reason letting the cpp know about false/true. As
> I
> > said in the last version, the only reason seem to be for the userspace.
> Well, as
> > there is no program of my knowlage that needs it, they were removed.
> > 
> If we don't expect this to show up in the ABI (which I hope is true), then
> the definition should probably be inside of #ifdef __KERNEL__. Right
> now, it's inside of (!__KERNEL_STRICT_NAMES), which is not exactly the
> same.

Thanks

What do you think about this?:

diff --git a/include/linux/types.h b/include/linux/types.h
index 3f23566..406d4ae 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -33,6 +33,8 @@ typedef __kernel_clockid_t	clockid_t;
 typedef __kernel_mqd_t		mqd_t;
 
 #ifdef __KERNEL__
+typedef _Bool			bool;
+
 typedef __kernel_uid32_t	uid_t;
 typedef __kernel_gid32_t	gid_t;
 typedef __kernel_uid16_t        uid16_t;


> 	Arnd <><

/Richard

