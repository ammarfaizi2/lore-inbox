Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263684AbUEGQiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263684AbUEGQiJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 12:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbUEGQiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 12:38:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:49617 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263684AbUEGQiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 12:38:07 -0400
Date: Fri, 7 May 2004 09:38:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Stas Sergeev <stsp@aknet.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in IO bitmap handling? Probably exploitable (2.6.5)
In-Reply-To: <409BA6B1.7030809@aknet.ru>
Message-ID: <Pine.LNX.4.58.0405070932230.3271@ppc970.osdl.org>
References: <409BA6B1.7030809@aknet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 May 2004, Stas Sergeev wrote:
> 
> Can someone please confirm (or refute) the presense of the bug there?

Looks very true, and your patch looks fine too, except we should use
"get_cpu()" and "put_cpu()" to make sure that kernel preemption does not
change the CPU in the middle of the operation.

Thanks,

		Linus
