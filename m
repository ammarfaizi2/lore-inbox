Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbVDTR3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVDTR3n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 13:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVDTRSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 13:18:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:30911 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261742AbVDTRQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 13:16:48 -0400
Date: Wed, 20 Apr 2005 10:16:44 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Ed L Cashin <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org, ecashin@coraid.com, greg@kroah.com
Subject: Re: [PATCH 2.6.12-rc2] aoe [1/6]: improve allowed interfaces
 configuration
Message-Id: <20050420101644.3d475ff5.rddunlap@osdl.org>
In-Reply-To: <874qe1pejv.fsf@coraid.com>
References: <874qe1pejv.fsf@coraid.com>
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

On Wed, 20 Apr 2005 13:02:12 -0400 Ed L Cashin wrote:

Just a nit/typo:

| +    modprobe aoe_iflist="eth1 eth3"

|  static char aoe_iflist[IFLISTSZ];
| +module_param_string(aoe_iflist, aoe_iflist, IFLISTSZ, 0600);
| +MODULE_PARM_DESC(aoe_iflist, " aoe_iflist=\"dev1 [dev2 ...]\n");

No leading space (" aoe_iflist=") and put a trailing \" in it:

  +MODULE_PARM_DESC(aoe_iflist, "aoe_iflist=\"dev1 [dev2 ...]\"\n");


---
~Randy
