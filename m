Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVAHNLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVAHNLB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 08:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVAHNLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 08:11:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13986 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261159AbVAHNKs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 08:10:48 -0500
Date: Sat, 8 Jan 2005 13:10:45 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       mingo@elte.hu, paulmck@us.ibm.com, arjan@infradead.org,
       linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
       pbadari@us.ibm.com, markv@us.ibm.com, greghk@us.ibm.com,
       torvalds@osdl.org
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050108131045.GB26051@parcelfarce.linux.theplanet.co.uk>
References: <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050106152621.395f935e.akpm@osdl.org> <20050106234123.GA27869@infradead.org> <20050106162928.650e9d71.akpm@osdl.org> <20050107002624.GA29006@infradead.org> <20050107090014.GA24946@elte.hu> <20050107091542.GA5295@infradead.org> <20050107140034.46aec534.akpm@osdl.org> <20050107233246.GH14108@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107233246.GH14108@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 12:32:47AM +0100, Adrian Bunk wrote:
> - wasts space for all users of Linux (e.g. some of the recent removals
>   are "remove EXPORT_SYMBOL'ed but completely unused function" patches
>   I sent)

Note that this alone is *NOT* enough for removal - there are groups of
functions that basically are libraries and that are supposed to be
exported, whether we have all of them used in the tree at given time
or not.
