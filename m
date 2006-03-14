Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751664AbWCNABQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbWCNABQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 19:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbWCNABQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 19:01:16 -0500
Received: from vena.lwn.net ([206.168.112.25]:23966 "HELO lwn.net")
	by vger.kernel.org with SMTP id S1751677AbWCNABP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 19:01:15 -0500
Message-ID: <20060314000114.24716.qmail@lwn.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: radix tree safety 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Mon, 13 Mar 2006 15:50:58 PST."
             <20060313155058.1389ee9a.akpm@osdl.org> 
Date: Mon, 13 Mar 2006 17:01:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> I don't really see the need - if someone goes and overindexes the data
> structure's capacity then they have a bug and hopefully that'll turn up in
> testing and will get fixed.
> 
> Or am I missing something obvious which makes radix-trees particularly
> dangerous or subtle??

There's nothing in the interface documentation which says that a tag is
an index to anything.  It's an integer value which can be attached to an
item in a radix tree.  One has to look into the source to see the
limitation built into it.  

If we don't want the tests, fine, but it might make sense to fix the
interface documentation, at least, to note that "tag" is not an
arbitrary integer value.

jon
