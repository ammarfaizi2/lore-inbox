Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268534AbUI3CkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268534AbUI3CkP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 22:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268609AbUI3CkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 22:40:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:8362 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268534AbUI3CkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 22:40:11 -0400
Date: Wed, 29 Sep 2004 22:29:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: adilger@clusterfs.com, slpratt@austin.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Simplified Readahead
Message-Id: <20040929222938.47d2f976.akpm@osdl.org>
In-Reply-To: <1096511206.5481.58.camel@dyn319181.beaverton.ibm.com>
References: <Pine.LNX.4.44.0409291113580.4449-600000@localhost.localdomain>
	<415B3845.3010005@austin.ibm.com>
	<20040929231327.GM2061@schnapps.adilger.int>
	<1096511206.5481.58.camel@dyn319181.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Pai <linuxram@us.ibm.com> wrote:
>
> On Wed, 2004-09-29 at 16:13, Andreas Dilger wrote:
> > On a readahead-related note, I'm wondering how hard it would be to have
> > some tunables and/or hooks from the readahead state manchine made
> > available to the filesystem?  With the 2.4 readahead code it was basically
> > impossible for the filesystem to disable the readahead, I haven't looked
> > at the 2.6 readahead enough to determine whether we need that or not.
> > 
> The best way currently to shutoff readahead is to poke into the file
> descriptors' readahead structure and set ra_pages to 0.

fadvise(fd, POSIX_FADV_RANDOM).
