Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317276AbSGIAJa>; Mon, 8 Jul 2002 20:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317277AbSGIAJ3>; Mon, 8 Jul 2002 20:09:29 -0400
Received: from revdns.flarg.info ([213.152.47.18]:37041 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S317276AbSGIAJ1>;
	Mon, 8 Jul 2002 20:09:27 -0400
Date: Tue, 9 Jul 2002 01:11:35 +0100
From: Dave Jones <davej@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [patch] 2.5.25 net/core/Makefile
Message-ID: <20020709001135.GA21383@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>, Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <29446.1025944229@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29446.1025944229@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 06, 2002 at 06:30:29PM +1000, Keith Owens wrote:
 > The valid combination of CONFIG_NET=n, CONFIG_LLC undefined incorrectly
 > builds ext8022.o and gets unresolved references because there is no
 > network code.  Detected by kbuild 2.5, not detected by the existing
 > build system.

And this breaks the valid combination of CONFIG_NET=y, CONFIG_LLC undef'd

net/network.o: In function Register_8022_client':
net/network.o(.text+0xe8b7): undefined reference to Llc_register_sap'
net/network.o: In function Unregister_8022_client':
net/network.o(.text+0xe8fe): undefined reference to Llc_unregister_sap'


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
