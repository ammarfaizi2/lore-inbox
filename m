Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWFSLdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWFSLdj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 07:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWFSLdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 07:33:39 -0400
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:63398 "EHLO
	mail-gw2.sa.eol.hu") by vger.kernel.org with ESMTP id S932352AbWFSLdi
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 07:33:38 -0400
To: reiser@namesys.com
CC: nix@esperi.org.uk, akpm@osdl.org, vs@namesys.com, hch@infradead.org,
       Reiserfs-Dev@namesys.com, Linux-Kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <449668D1.1050200@namesys.com> (message from Hans Reiser on Mon,
	19 Jun 2006 02:05:21 -0700)
Subject: Re: batched write
References: <44736D3E.8090808@namesys.com> <20060524175312.GA3579@zero>	<44749E24.40203@namesys.com> <20060608110044.GA5207@suse.de>	<1149766000.6336.29.camel@tribesman.namesys.com>	<20060608121006.GA8474@infradead.org>	<1150322912.6322.129.camel@tribesman.namesys.com>	<20060617100458.0be18073.akpm@osdl.org> <4494411B.4010706@namesys.com> <87ac8an21r.fsf@hades.wkstn.nix> <449668D1.1050200@namesys.com>
Message-Id: <E1FsHzf-0004ES-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 19 Jun 2006 13:32:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Forgive myn utter ignorance of fuse, but does it currently context
> switch to user space for every 4k written through VFS?

Yes, unfortunately it does, so fuse would benefit from batched writing
as well, with some constraint on the number of locked pages to avoid
DoS against the page cache.

Miklos
