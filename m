Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264260AbUEXMA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbUEXMA7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 08:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbUEXMA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 08:00:59 -0400
Received: from canuck.infradead.org ([205.233.217.7]:36615 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S264260AbUEXMA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 08:00:57 -0400
Date: Mon, 24 May 2004 08:00:49 -0400
From: hch@infradead.org
To: "Peter J. Braam" <braam@clusterfs.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       "'Phil Schwan'" <phil@clusterfs.com>
Subject: Re: [PATCH/RFC] Lustre VFS patch
Message-ID: <20040524120049.GA26863@infradead.org>
Mail-Followup-To: hch@infradead.org, "Peter J. Braam" <braam@clusterfs.com>,
	torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
	'Phil Schwan' <phil@clusterfs.com>
References: <20040524114009.96CE13100E2@moraine.clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524114009.96CE13100E2@moraine.clusterfs.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any chance you could please send one mail per patch the next time?
That makes reviewing them a lot easier.

> export-vanilla-2.6.patch
>  
>   Export symbols used by Lustre.

 	inodes_stat.nr_unused--;
 }
 
+EXPORT_SYMBOL(__iget);

	Explanation please, look completely bogus.

+EXPORT_SYMBOL(do_kern_mount);

	Explanation please, while not completely bogus probably
	bogus in this context.

+EXPORT_SYMBOL(truncate_complete_page);

	Dito, this looks completely bogus to.

 EXPORT_SYMBOL(kallsyms_lookup);
 EXPORT_SYMBOL(__print_symbol);
+EXPORT_SYMBOL(kernel_text_address);

	no way

+EXPORT_SYMBOL(reparent_to_init);

	bogus.  All your kernel threads should call daemonize()

 
+EXPORT_SYMBOL(exit_files);

	dito.

