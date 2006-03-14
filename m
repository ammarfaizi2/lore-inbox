Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWCNARE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWCNARE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 19:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWCNARE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 19:17:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13755 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750770AbWCNARD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 19:17:03 -0500
Date: Mon, 13 Mar 2006 16:14:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: corbet@lwn.net (Jonathan Corbet)
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: radix tree safety
Message-Id: <20060313161435.30c2d865.akpm@osdl.org>
In-Reply-To: <20060314000114.24716.qmail@lwn.net>
References: <20060313155058.1389ee9a.akpm@osdl.org>
	<20060314000114.24716.qmail@lwn.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

corbet@lwn.net (Jonathan Corbet) wrote:
>
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > I don't really see the need - if someone goes and overindexes the data
> > structure's capacity then they have a bug and hopefully that'll turn up in
> > testing and will get fixed.
> > 
> > Or am I missing something obvious which makes radix-trees particularly
> > dangerous or subtle??
> 
> There's nothing in the interface documentation which says that a tag is
> an index to anything.  It's an integer value which can be attached to an
> item in a radix tree.  One has to look into the source to see the
> limitation built into it.  
> 
> If we don't want the tests, fine, but it might make sense to fix the
> interface documentation, at least, to note that "tag" is not an
> arbitrary integer value.
> 

Sure, we can live with the runtime cost of a documentation fix ;)
