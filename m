Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUJGQIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUJGQIq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 12:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267433AbUJGQIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 12:08:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:24265 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261232AbUJGQES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 12:04:18 -0400
Date: Thu, 7 Oct 2004 08:56:39 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: anil dahiya <ak_ait@yahoo.com>
Cc: nhorman@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: about Linux Module Profiling Tool
Message-Id: <20041007085639.09f2701b.rddunlap@osdl.org>
In-Reply-To: <20041007132343.83278.qmail@web60206.mail.yahoo.com>
References: <41653E3D.4020508@redhat.com>
	<20041007132343.83278.qmail@web60206.mail.yahoo.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004 06:23:43 -0700 (PDT) anil dahiya wrote:

| anil kumar : 
|  > If anyone have idea about linux module profiling
|  > tools>> >  
| 
| Neil :
|   > What kind of profiling do you want to do?
|   
| 
| Anil Kumar :
| 
| after booting system, I am loading my network device
| driver module in linux kernel .
| 
| I wanna to know how much time is taking by functions
| of my module at any time (i.e just after loading
| module or just after sending or receiving data etc).
| So I  can improve performance of my module by
| improving those function which taking maximum time or 
| cpu utilization.


Check out oprofile:
in kernel tree, Documentation/basic_profiling.txt (2.6.x)

Basic in-kernel profiling (older version, before oprofile)
does not work with loadable modules, just with in-kernel code.
You could use this if you build your driver in-kernel.

There are also some performance-counter patches, but
I don't know how to use them [if your h/w supports them].

-- 
~Randy
MOTD:  Always include version info.
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)
