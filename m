Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbTLORbp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 12:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTLORbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 12:31:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:44683 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263922AbTLORbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 12:31:43 -0500
Date: Mon, 15 Dec 2003 09:22:06 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: root@chaos.analogic.com, kpfleming@backtobasicsmgmt.com,
       hahn@physics.mcmaster.ca, linux-kernel@vger.kernel.org, mj@ucw.cz
Subject: Re: PCI Express support for 2.4 kernel
Message-Id: <20031215092206.01db1429.rddunlap@osdl.org>
In-Reply-To: <3FDDEE32.7050900@intel.com>
References: <Pine.LNX.4.44.0312150917170.32061-100000@coffee.psychology.mcmaster.ca>
	<3FDDD8C6.3080804@intel.com>
	<3FDDDC68.80209@backtobasicsmgmt.com>
	<3FDDE39E.1050300@intel.com>
	<Pine.LNX.4.53.0312151150090.10342@chaos>
	<3FDDEE32.7050900@intel.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Dec 2003 19:24:02 +0200 Vladimir Kondratiev <vladimir.kondratiev@intel.com> wrote:

| Richard B. Johnson wrote:
| <discussion regarding initializers for static vars>
| 
| Let's stop this discussion, it leads to nowhere. Probable, yes, 
| initializer do add bytes to the data segment. But it does not make 
| difference for memory image after loading, do it?
| 
| Does this difference in executable size worth potential risk of error?
| 
| Anyway, common style in kernel seems to be to do initialize static vars, 
| even to 0. There are plenty of examples, including the same file, (for 
| 2.4.23)
| 
| arch/i386/kernel/pci-pc.c:32
| static int pci_using_acpi_prt = 0;
| 
| or
| 
| arch/i386/kernel/setup.c:1241
| static int tsc_disable __initdata = 0;
| 
| Finally, let's stop this thread. Let it be up to person who will be (if 
| it will happen) checking this code into kernel, to decide on coding 
| style. I, personally, value code clarity more then 4 bytes in executable 
| size. But I will not object if more experienced kernel maintainers have 
| another priority.

You seem to be missing that you shouldn't be looking in 2.4.x but in
2.6.x instead.  2.6.x has had hundreds++ of 0 initializers removed from it.

--
~Randy
MOTD:  Always include version info.
