Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWJQVrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWJQVrm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWJQVrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:47:42 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:61339 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750960AbWJQVrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:47:41 -0400
Subject: Re: [PATCH] Restore sysctl syscall option for non-embedded users
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Cal Peake <cp@absolutedigital.net>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Jan Beulich <jbeulich@novell.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Eric Biederman <ebiederm@xmission.com>
In-Reply-To: <Pine.LNX.4.64.0610171401130.10587@lancer.cnet.absolutedigital.net>
References: <453519EE.76E4.0078.0@novell.com>
	 <20061017091901.7193312a.rdunlap@xenotime.net>
	 <Pine.LNX.4.64.0610171401130.10587@lancer.cnet.absolutedigital.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Oct 2006 23:11:36 +0100
Message-Id: <1161123096.5014.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-10-17 am 14:17 -0400, ysgrifennodd Cal Peake:
> My dmesg gets spammed to all hell with these warnings. Can we keep this 
> option easily visible till it gets ripped out Jan of 2007 (see 
> Documentation/feature-removal-schedule.txt for reference)?

NAK

The problem is that this option is available at all. Deprecating
syscalls especially trivial ones is fundamentally wrong. The correct fix
is to make sysctl always present except as an option for embedded and
not to deprecate it.


