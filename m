Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751625AbWGZOWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbWGZOWo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 10:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWGZOWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 10:22:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8918 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751625AbWGZOWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 10:22:43 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1153787433.31581.41.camel@josh-work.beaverton.ibm.com> 
References: <1153787433.31581.41.camel@josh-work.beaverton.ibm.com> 
To: Josh Triplett <josht@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] [afs] Add lock annotations to afs_proc_cell_servers_{start,stop} 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 26 Jul 2006 15:22:30 +0100
Message-ID: <14452.1153923750@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Triplett <josht@us.ibm.com> wrote:

> afs_proc_cell_servers_start acquires a lock, and afs_proc_cell_servers_stop
> releases that lock.  Add lock annotations to these two functions so that
> sparse can check callers for lock pairing, and so that sparse will not
> complain about these functions since they intentionally use locks in this
> manner.

Looks reasonable, though I'm surprised you can get this sort of checking to
work in sparse.

Acked-By: David Howells <dhowells@redhat.com>
