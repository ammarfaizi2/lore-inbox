Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263498AbTJVT0I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 15:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263502AbTJVT0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 15:26:08 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:12307 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S263498AbTJVT0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 15:26:06 -0400
Date: Mon, 20 Oct 2003 04:44:28 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "Noah J. Misch" <noah@caltech.edu>
Cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] Make LLC2 compile with PROC_FS=n
Message-ID: <20031020074428.GA26494@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"Noah J. Misch" <noah@caltech.edu>, rddunlap@osdl.org,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <Pine.GSO.4.58.0310171452540.13905@blinky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0310171452540.13905@blinky>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Oct 19, 2003 at 10:03:52PM -0700, Noah J. Misch escreveu:
> Hello Arnaldo,
> 
> This patch allows the LLC2 code to link properly when CONFIG_PROC_FS=n.  The
> problem was that the Makefile only built llc_proc.c when PROC_FS=y/m, but
> af_llc.c called functions in that file in all cases.  The log details how I
> fixed this.
> 
> I think this is the best fix, but of course there are a number of less intrusive
> fixes, including (I think) one as simple as making llc_proc.c always compile.
> This one does apply cleanly to linux-2.5 BK as of 0400 UTC 10/20/2003 and passes
> allyesconfig and (allyesconfig - PROC_FS) compiles on i386.
> 
> Please let me know if I should supply you with further information.

I'm OK with this patch.

- Arnaldo
