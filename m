Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030398AbVJEW1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbVJEW1d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 18:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbVJEW1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 18:27:33 -0400
Received: from darwin.snarc.org ([81.56.210.228]:30617 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S1030398AbVJEW1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 18:27:32 -0400
Date: Thu, 6 Oct 2005 00:27:31 +0200
From: Vincent Hanquez <vincent@snarc.org>
To: Junio C Hamano <junkio@cox.net>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: clone: I'm only doing a max of 256 requests
Message-ID: <20051005222730.GA16593@snarc.org>
References: <20051005191300.GC17475@hexapodia.org> <7virwbu4wz.fsf@assigned-by-dhcp.cox.net> <7vhdbvk6ln.fsf@assigned-by-dhcp.cox.net> <7vy857iqzh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7vy857iqzh.fsf@assigned-by-dhcp.cox.net>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 02:38:42PM -0700, Junio C Hamano wrote:
> Hmph.  I was reading linux-2.6/fs/exec.c::copy_strings(), but I
> do not see any such size limit (other than exceeding the total
> machine memory size, probably reported by alloc_page() failing)
> imposed there.  Am I looking at the wrong place?

well at least the len of argv is limited by ~32K (i386) by: 

bprm->p = PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
...
bprm->argc = count(argv, bprm->p / sizeof(void *));

-- 
Vincent Hanquez
