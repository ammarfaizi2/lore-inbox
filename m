Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262284AbUJZOk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbUJZOk0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 10:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbUJZOk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 10:40:26 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:56572 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262284AbUJZOjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 10:39:17 -0400
Date: Tue, 26 Oct 2004 07:39:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Jean-Christophe Dubois <jdubois@mc.com>, kai@germaschewski.name,
       sam@ravnborg.org
Subject: Re: [PATCH 2.6.9] kbuild warning fixes on Solaris 9
Message-ID: <20041026143915.GR25154@smtp.west.cox.net>
References: <20041025224907.GL25154@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025224907.GL25154@smtp.west.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 03:49:07PM -0700, Tom Rini wrote:

> The following set of patches is based loosely on the patches that
> Jean-Christophe Dubois came up with for 2.6.7.  Where as the original
> patches added a number of casts to unsigned char, I went the route of
> making the chars be explicitly signed.  I honestly don't know which
> route is better to go down.  Doing this is the bulk of the patch.  Out
> of the rest of the odds 'n ends is that on Solaris, Elf32_Word is a
> ulong, which means all of the printf's are unhappy (uint format, ulong
> arg) for most of the typedefs.

In response to some off-list comments, HOSTCC is gcc-3.3.1 and the char
-> signed char changes are for warnings like:
scripts/basic/fixdep.c:239: warning: subscript has type `char'

-- 
Tom Rini
http://gate.crashing.org/~trini/
