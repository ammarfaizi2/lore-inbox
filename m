Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWFFVWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWFFVWd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 17:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWFFVWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 17:22:33 -0400
Received: from xenotime.net ([66.160.160.81]:37069 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751120AbWFFVWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 17:22:33 -0400
Date: Tue, 6 Jun 2006 14:25:19 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: paulkf@microgate.com, davej@redhat.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] fix missing hdlc symbols for synclink drivers
Message-Id: <20060606142519.9bf9d037.rdunlap@xenotime.net>
In-Reply-To: <m3hd2yc7ls.fsf@defiant.localdomain>
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	<20060605230248.GE3963@redhat.com>
	<20060605184407.230bcf73.rdunlap@xenotime.net>
	<1149622813.11929.3.camel@amdx2.microgate.com>
	<m3u06yc9mr.fsf@defiant.localdomain>
	<20060606134816.363cbeca.rdunlap@xenotime.net>
	<m3hd2yc7ls.fsf@defiant.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jun 2006 23:11:27 +0200 Krzysztof Halasa wrote:

> Hi,
> 
> "Randy.Dunlap" <rdunlap@xenotime.net> writes:
> 
> > I think that the main problem is that SYNCLINK wants to be able
> > to use some functions from hdlc_generic.c when
> > CONFIG_HDLC=m.  How do you handle that?
> 
> I don't :-)
> 
> If CONFIG_HDLC=m then all hw drivers below can only be modules.

OK.  We have:

with partial .config:
# CONFIG_WAN is not set
CONFIG_HDLC=m
# CONFIG_HDLC_RAW is not set
# CONFIG_HDLC_RAW_ETH is not set
# CONFIG_HDLC_CISCO is not set
# CONFIG_HDLC_FR is not set
# CONFIG_HDLC_PPP is not set
...
CONFIG_SYNCLINK=m
CONFIG_SYNCLINK_HDLC=y
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINKMP_HDLC=y
CONFIG_SYNCLINK_GT=m
CONFIG_SYNCLINK_GT_HDLC=y
CONFIG_N_HDLC=m

and still get missing/unresolved symbols...


---
~Randy
