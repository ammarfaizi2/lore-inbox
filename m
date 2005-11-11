Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbVKKKiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbVKKKiP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 05:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVKKKiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 05:38:15 -0500
Received: from isilmar.linta.de ([213.239.214.66]:29591 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932350AbVKKKiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 05:38:14 -0500
Date: Fri, 11 Nov 2005 11:38:08 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: npiggin@suse.de, linux-kernel@vger.kernel.org
Subject: PageReserved removal woes: vbetool, suspend-to-ram breakage
Message-ID: <20051111103808.GA22057@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	npiggin@suse.de, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Just wanted to let you know that the warning introduced in
[PATCH] core remove PageReserved
triggers when using vbetool, which is needed on several systems for proper
suspend-to-mem support:

[4301282.746000] program vbetool is using MAP_PRIVATE, PROT_WRITE mmap of
		 VM_RESERVED memory, which is deprecated. Please report
		 this to linux-kernel@vger.kernel.org

Reports of this haven't generated many results yet, that's why I'm
addressing this with a subject line which startles more people ;)
http://lkml.org/lkml/2005/11/6/72
http://lkml.org/lkml/2005/11/6/76
http://lkml.org/lkml/2005/11/10/280

	Dominik
