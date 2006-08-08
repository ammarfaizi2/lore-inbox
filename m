Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030306AbWHHXeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbWHHXeW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 19:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbWHHXeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 19:34:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:50616 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030306AbWHHXeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 19:34:21 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 1/2] Split i386 and x86_64 ptrace.h
References: <200608082058.k78KwGa4006531@ccure.user-mode-linux.org>
From: Andi Kleen <ak@suse.de>
Date: 09 Aug 2006 01:33:43 +0200
In-Reply-To: <200608082058.k78KwGa4006531@ccure.user-mode-linux.org>
Message-ID: <p73u04mol9k.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> writes:
> 
> x86_64 is also treated in this way for consistency.
> 
> This patch was run by linux-arch yesterday with no comment.

Well you should have sent it to me. 

I think I would prefer a well placed ifdef __KERNEL__ or two for this - i don't
like it when it becomes harder to grep include files like this
(like the errno->errno-base split was quite bad in this regard)

-Andi

