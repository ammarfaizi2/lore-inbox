Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422658AbWBBBW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422658AbWBBBW1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 20:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbWBBBW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 20:22:27 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:4778 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161065AbWBBBW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 20:22:27 -0500
Subject: Re: 2.6.15-rt16
From: Steven Rostedt <rostedt@goodmis.org>
To: Clark Williams <williams@redhat.com>
Cc: chris perkins <cperkins@OCF.Berkeley.EDU>, linux-kernel@vger.kernel.org
In-Reply-To: <1138833380.18762.67.camel@localhost.localdomain>
References: <Pine.SOL.4.63.0601300839050.8546@conquest.OCF.Berkeley.EDU>
	 <1138640592.12625.0.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601300917120.8546@conquest.OCF.Berkeley.EDU>
	 <1138653235.26657.7.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601310946000.8770@conquest.OCF.Berkeley.EDU>
	 <1138730835.5959.3.camel@localhost.localdomain>
	 <1138818770.6685.1.camel@localhost.localdomain>
	 <1138819142.18762.10.camel@localhost.localdomain>
	 <1138830476.6632.5.camel@localhost.localdomain>
	 <1138830694.18762.46.camel@localhost.localdomain>
	 <1138832179.6632.12.camel@localhost.localdomain>
	 <1138833380.18762.67.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 01 Feb 2006 20:22:15 -0500
Message-Id: <1138843335.6632.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clark,

[...]
switchroot: exec'ing /sbin/init
init[1]: segfault at ffffffff8010fadc rip ffffffff8010fadc rsp 00007fffffdacfc8 error 15
Kernel panic - not syncing: Segfault in init
[...]


Could you find where that ffffffff8010fadc is.  Compile with debug info,
and (what I do) is a "gdb vmlinux" and "li *0xffffffff8010fadc" to find
the location.  The dump may be something that is done after the init
exits.

-- Steve


