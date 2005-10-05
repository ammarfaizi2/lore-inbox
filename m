Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030388AbVJEVip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbVJEVip (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 17:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbVJEVip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 17:38:45 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:65183 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030384AbVJEVio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 17:38:44 -0400
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: Re: clone: I'm only doing a max of 256 requests
References: <20051005191300.GC17475@hexapodia.org>
	<7virwbu4wz.fsf@assigned-by-dhcp.cox.net>
	<7vhdbvk6ln.fsf@assigned-by-dhcp.cox.net>
cc: linux-kernel@vger.kernel.org
Date: Wed, 05 Oct 2005 14:38:42 -0700
In-Reply-To: <7vhdbvk6ln.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 05 Oct 2005 14:16:04 -0700")
Message-ID: <7vy857iqzh.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> 1. As a stop gap measure, so that your Linux kernel work can
>    continue, please bump MAX_NEEDS definition in upload-pack.c
>    from 256 to a bit higher.  That controls the number of
>    40-letter SHA1 given to underlying rev-list via execvp(), so
>    it cannot be _too_ big like 1M, lest it exceeds the exec
>    argument buffer limit.

Hmph.  I was reading linux-2.6/fs/exec.c::copy_strings(), but I
do not see any such size limit (other than exceeding the total
machine memory size, probably reported by alloc_page() failing)
imposed there.  Am I looking at the wrong place?

