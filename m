Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262411AbVGLUxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbVGLUxu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 16:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbVGLUxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 16:53:47 -0400
Received: from rgminet02.oracle.com ([148.87.122.31]:63209 "EHLO
	rgminet02.oracle.com") by vger.kernel.org with ESMTP
	id S262411AbVGLUwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 16:52:24 -0400
Date: Tue, 12 Jul 2005 13:52:09 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rc2-mm2] update tmpfs for new delete_inode behavior
Message-ID: <20050712205209.GE14505@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <Pine.LNX.4.61.0507121508520.6933@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507121508520.6933@goblin.wat.veritas.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 03:22:11PM +0100, Hugh Dickins wrote:
> LTP on tmpfs hits kernel BUG at mm/shmem.c:680!  shmem_delete_inode needs
> to truncate_inode_pages for itself now.  It's not immediately obvious since
> many cases get covered by shmem_truncate's followup truncate_inode_pages:
> maybe with thought we can just call it once, but right now fix the BUG.
Erf, indeed I missed that one.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
