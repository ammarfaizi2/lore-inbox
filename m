Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWIVCHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWIVCHF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 22:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWIVCHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 22:07:04 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:56777 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932205AbWIVCHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 22:07:01 -0400
Date: Fri, 22 Sep 2006 11:09:39 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: kmannth@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, clameter@engr.sgi.com
Subject: Re: [BUG] i386 2.6.18 cpu_up: attempt to bring up CPU 4 failed :
 kernel BUG at mm/slab.c:2698!
Message-Id: <20060922110939.8bf65ed8.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1158888843.5657.44.camel@keithlap>
References: <1158884252.5657.38.camel@keithlap>
	<20060921174134.4e0d30f2.akpm@osdl.org>
	<1158888843.5657.44.camel@keithlap>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 18:34:03 -0700
keith mannthey <kmannth@us.ibm.com> wrote:
> > b) pageset_cpuup_callback()'s CPU_UP_CANCELED path possibly hasn't been
> >    tested before.  I'd be guessing that we're not zeroing out the
> >    zone.pageset[] array when the `struct zone' is first allocated, but I
> >    don't immediately recall where that code lives.
> 

Just a question. Because process_zones(cpu) is called at CPU_UP_PREPARE,
cpu_to_node(cpu) should be fixed before CPU_UP_PREPARE ?
(If so, I should revert a patch I sent today...)

-Kame

