Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262442AbSI3Oxo>; Mon, 30 Sep 2002 10:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbSI3Oxo>; Mon, 30 Sep 2002 10:53:44 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:9626 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262442AbSI3Oxn>; Mon, 30 Sep 2002 10:53:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Michael Clark <michael@metaparadigm.com>
Subject: Re: v2.6 vs v3.0
Date: Mon, 30 Sep 2002 09:26:56 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <200209290114.15994.jdickens@ameritech.net> <02093008055700.15956@boiler> <3D98567E.5010502@metaparadigm.com>
In-Reply-To: <3D98567E.5010502@metaparadigm.com>
MIME-Version: 1.0
Message-Id: <02093009265603.15956@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 September 2002 08:49, Michael Clark wrote:
> On 09/30/02 21:05, Kevin Corry wrote:
> > EVMS is now up-to-date and running on 2.5.39. You can get the latest
> > kernel code from CVS (http://sourceforge.net/cvs/?group_id=25076) or
> > Bitkeepr (http://evms.bkbits.net/). There will be a new, full release
> > (1.2) coming out this week.
>
> Yes, i just booted up with EVMS CVS on 2.5.39. Detected all my LVM LV's
> fine. After cautious tests with them mounted ro, i then preceded to mount
> them rw and continued boot up. Working fine so far. Great work.
>
> All i needed to do was change my vgscan to evms_vgscan and adjust my mount
> points to the new style ( /dev/evms/lvm/<vg></<lv> ).

Instead of using "evms_vgscan", you should probably run "evms_rediscover". 
But you really only need that if you've compiled EVMS as modules in your 
kernel.

For volume admin tasks, I would recommend using "evmsgui" if you have X 
available, or "evmsn" if you need text-mode.

The LVM-style commands (like evms_vgscan) were originally written as testing 
tools before we had the fully-functional UIs. They were left around as kind 
of a proof-of-concept that the EVMS engine library API can be used to emulate 
existing volume management tools.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
