Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264233AbUA3VYy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 16:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264321AbUA3VYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 16:24:54 -0500
Received: from hoemail1.lucent.com ([192.11.226.161]:17374 "EHLO
	hoemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S264233AbUA3VYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 16:24:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16410.51656.221208.976055@gargle.gargle.HOWL>
Date: Fri, 30 Jan 2004 16:16:56 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: Andrew Morton <akpm@osdl.org>
Cc: thockin@sun.com, arjanv@redhat.com, thomas.schlichter@web.de,
       thoffman@arnor.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-rc2-mm2
In-Reply-To: <20040130123301.70009427.akpm@osdl.org>
References: <20040130014108.09c964fd.akpm@osdl.org>
	<1075489136.5995.30.camel@moria.arnor.net>
	<200401302007.26333.thomas.schlichter@web.de>
	<1075490624.4272.7.camel@laptop.fenrus.com>
	<20040130114701.18aec4e8.akpm@osdl.org>
	<20040130201731.GY9155@sun.com>
	<20040130123301.70009427.akpm@osdl.org>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

Andrew> Can we do d)?

Andrew> static long do_setgroups(int gidsetsize, gid_t __user *user_grouplist,
Andrew> 			gid_t *kern_grouplist)
Andrew> {
Andrew> 	gid_t groups[NGROUPS];

Call me stupid, but what if we accept the patches to increase the
number of groups, won't that make this array be huge potentially?
Shouldn't we instead do a kmalloc() using current->ngroups instead?

John
