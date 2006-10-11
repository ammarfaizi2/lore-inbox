Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161216AbWJKUUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161216AbWJKUUE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 16:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161227AbWJKUUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 16:20:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4015 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161216AbWJKUUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 16:20:01 -0400
Date: Wed, 11 Oct 2006 13:19:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Chandra Seetharaman <sekharan@us.ibm.com>, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Allow more than PAGESIZE data read in configfs
Message-Id: <20061011131935.448a8696.akpm@osdl.org>
In-Reply-To: <20061010203511.GF7911@ca-server1.us.oracle.com>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	<20061010203511.GF7911@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 13:35:11 -0700
Joel Becker <Joel.Becker@oracle.com> wrote:

> On Tue, Oct 10, 2006 at 11:20:43AM -0700, Chandra Seetharaman wrote:
> > Currently, maximum amount of data that can be read from a configfs
> > attribute file is limited to PAGESIZE bytes. This is a limitation for
> > some of the usages of configfs.
> 
> 	NAK.  This forces a complex and inappropriate interface on the
> majority of users, and doesn't honor configfs' simplicity-first design.

The patch deletes a pile of custom code from configfs and replaces it with
calls to standard kernel infrastructure and fixes a shortcoming/bug in the
process.  Migration over to the new interface is trivial and almost
scriptable.

Nice patch.  What's not to like about it??

> 	I understand Chandra's concerns, but this patch isn't the right
> way to do it.

To do what?  Fix the artificial PAGE_SIZE contraint?  The patch would be
justified on cleanup grounds even if nobody was hitting that limit.
