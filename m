Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267368AbTA1PmY>; Tue, 28 Jan 2003 10:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267370AbTA1PmY>; Tue, 28 Jan 2003 10:42:24 -0500
Received: from [213.86.99.237] ([213.86.99.237]:32254 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267368AbTA1PmX>; Tue, 28 Jan 2003 10:42:23 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20030127221523.GP20972@ca-server1.us.oracle.com> 
References: <20030127221523.GP20972@ca-server1.us.oracle.com>  <20030127175917.GO20972@ca-server1.us.oracle.com> <Pine.LNX.4.44.0301271208580.18686-100000@chaos.physics.uiowa.edu> 
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Christian Zander <zander@minion.de>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 28 Jan 2003 15:43:57 +0000
Message-ID: <20656.1043768637@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Joel.Becker@oracle.com said:
> 	If my distribution has installed /usr/src/linux-x.y, I can't compile
> against it.  Even though the 200MB of a kernel tree is already taking
> up space on my system, I have to download *another* 30MB and install
> it as *another* 200MB and build it to an eventual *another* 260MB of
> kernel tree.  So, for every kernel I want to support, I have to have
> 260MB of built tree.  And that's just for my userid.  Anyone else on
> the box has to have their own n_kernels * 260MB of space waste.

Er, if vermagic.o needed to change, then your module build was broken
already and wouldn't have worked against the precompiled kernel. That's 
what vermagic.o is there for. You shouldn't need write permissions to the 
kernel source tree. Neither do you need _all_ of the kernel source; 
just the headers and appropriate bits of infrastructure.

--
dwmw2


