Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbTEBUiJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 16:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263156AbTEBUiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 16:38:09 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:39626 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP id S263150AbTEBUiI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 16:38:08 -0400
Subject: Re: 2.5.68-mm4
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20030502133405.57207c48.akpm@digeo.com>
References: <20030502020149.1ec3e54f.akpm@digeo.com>
	 <1051905879.2166.34.camel@spc9.esa.lanl.gov>
	 <20030502133405.57207c48.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1051908541.2166.40.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 02 May 2003 14:49:02 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-02 at 14:34, Andrew Morton wrote:
> Steven Cole <elenstev@mesatop.com> wrote:
> >
> > For what it's worth, kexec has worked for me on the following
> > two systems.
> > ...
> > 00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
> 
> Are you using eepro100 or e100?  I found that e100 failed to bring up the
> interface on restart ("failed selftest"), but eepro100 was OK.

CONFIG_EEPRO100=y
# CONFIG_EEPRO100_PIO is not set
# CONFIG_E100 is not set

I can test E100 again to verify if that would help.

Also, I found that if I mistyped the argument to do-kexec.sh, the
system would stay up, but the interface would get hosed, fixable with
/etc/rc.d/init.d/network restart.

Otherwise, kexec works fine here so far over about a dozen reboots on
both machines.

Steven

