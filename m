Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264281AbTGBRzs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 13:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbTGBRzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 13:55:48 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:59945 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S264256AbTGBRzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 13:55:43 -0400
Date: Wed, 2 Jul 2003 14:07:03 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Andrea Arcangeli <andrea@suse.de>, Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
In-Reply-To: <461030000.1057165809@flay>
Message-ID: <Pine.LNX.4.44.0307021406040.31191-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jul 2003, Martin J. Bligh wrote:

> Maybe I'm just taking this out of context, and it's twisting my brain,
> but as far as I know, the nonlinear vma's *are* backed by pte_chains.

They are, but IMHO they shouldn't be.  The nonlinear vmas are used
only for database shared memory segments and other "bypass the VM"
applications, so I don't see any reason why we need to complicate
things hopelessly in order to deal with corner cases like truncate.

