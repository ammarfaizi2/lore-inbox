Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVDUQdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVDUQdZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 12:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVDUQdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 12:33:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:61865 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261520AbVDUQdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 12:33:14 -0400
Date: Thu, 21 Apr 2005 09:32:48 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Ed L Cashin <ecashin@coraid.com>
Cc: greg@kroah.com, 7eggert@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc2] aoe [1/6]: improve allowed interfaces
 configuration
Message-Id: <20050421093248.2061fb1a.rddunlap@osdl.org>
In-Reply-To: <87pswoi1vl.fsf@coraid.com>
References: <3VqSf-2z7-15@gated-at.bofh.it>
	<E1DOVtj-0003bF-6c@be1.7eggert.dyndns.org>
	<87y8bcjlpq.fsf@coraid.com>
	<20050421145658.GA27263@kroah.com>
	<87pswoi1vl.fsf@coraid.com>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: SvC&!/v_Hr`MvpQ*|}uez16KH[#EmO2Tn~(r-y+&Jb}?Zhn}c:Eee&zq`cMb_[5`tT(22ms
 (.P84,bq_GBdk@Kgplnrbj;Y`9IF`Q4;Iys|#3\?*[:ixU(UR.7qJT665DxUP%K}kC0j5,UI+"y-Sw
 mn?l6JGvyI^f~2sSJ8vd7s[/CDY]apD`a;s1Wf)K[,.|-yOLmBl0<axLBACB5o^ZAs#&m?e""k/2vP
 E#eG?=1oJ6}suhI%5o#svQ(LvGa=r
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2005 11:30:06 -0400 Ed L Cashin wrote:

| Greg KH <greg@kroah.com> writes:
| 
| > On Thu, Apr 21, 2005 at 09:36:17AM -0400, Ed L Cashin wrote:
| >> "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" <7eggert@gmx.de> writes:
| >> 
| >> > Ed L Cashin <ecashin@coraid.com> wrote:
| >> >
| >> >> +++ b/Documentation/aoe/aoe.txt       2005-04-20 11:42:20.000000000 -0400
| >> >
| >> >> +  When the aoe driver is a module, use
| >> >
| >> > Is there any reason for this inconsistent behaviour?
| >> 
| >> Yes, the /sys/module/aoe area is only present when the aoe driver is a
| >> module.
| >
| > Not true, have you looked in /sys/module lately?  :)
| >
| >> It would be nicer if there were a sysfs area where I could
| >> put this file regardless of whether the driver is a module or built
| >> into the kernel.  
| >
| > That's the place for it.  It will be there if the driver is built as a
| > module or into the kernel.
| 
| Wow!  Well, that's very convenient for driver writers, so I'm pleased,
| and I can update the docs.  It surprises me, though, to find out that
| /sys/module is for things other than modules.

Just depends on your definition of a module.

AOE (or just about any device driver) can be considered logically
as a module.  You seem to be equating module with "loadable module"
vs. a builtin module.  The good news is that /sys/module works
for loadable or builtin modules.

---
~Randy
