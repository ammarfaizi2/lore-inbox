Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTEHPmA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 11:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbTEHPmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 11:42:00 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:4743
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261823AbTEHPl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 11:41:59 -0400
Subject: Re: The magical mystical changing ethernet interface order
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       Russell King <rmk@arm.linux.org.uk>, rddunlap@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1052395526.23259.0.camel@rth.ninka.net>
References: <20030507141458.B30005@flint.arm.linux.org.uk>
	 <20030507082416.0996c3df.rddunlap@osdl.org>
	 <20030507181410.A19615@flint.arm.linux.org.uk>
	 <20030507150414.1eaeae75.akpm@digeo.com>  <3EB98878.5060607@us.ibm.com>
	 <1052395526.23259.0.camel@rth.ninka.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052405730.10038.51.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 May 2003 15:55:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-08 at 13:05, David S. Miller wrote:
> This is absolutely not guarenteed.  The linker is at liberty to
> reorder objects in any order it so desires, for performance reasons
> etc.
> 
> Any reliance on link ordering is broken and needs to be fixed.

That ahould keep you amused for a year or two. Unfortunately for the ISA
driver code we *have* to rely on link order or rip out the __init stuff
and use Space.c type hacks.


