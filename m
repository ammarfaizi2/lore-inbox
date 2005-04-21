Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVDUXbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVDUXbT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 19:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVDUXbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 19:31:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:16018 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261153AbVDUXbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 19:31:17 -0400
Date: Thu, 21 Apr 2005 16:33:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
cc: Petr Baudis <pasky@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
In-Reply-To: <20050421232201.GD31207@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0504211629120.2344@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
 <20050421112022.GB2160@elf.ucw.cz> <20050421120327.GA13834@elf.ucw.cz>
 <20050421162220.GD30991@pasky.ji.cz> <20050421232201.GD31207@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Apr 2005, Pavel Machek wrote:
> 
> Is there way to say "git diff -r origin:" but dump it patch-by-patch
> with some usable headers?

In my git version there is a command called "git-export" for exactly this. 
I don't know if Pasky included that in his trees, but if not, you can just 
get my git tree (which should be compatible with Pasky's scripts, but mine 
just has the "core" stuff).

Using "git-export" you can export your whole git tree if you want to, but 
more commonly you'd say

	git-export $(cat .git/HEAD) $(cat .git/BASE)

where you'd have saved the previous head that you exported in the BASE
thing (or, if you pull my tree, and want to export your changes back to 
me, you'd initialize BASE to the original HEAD in my tree).

The output format of "git-export" is not the prettiest in the world, but 
I've never actually _used_ that command, I just wrote it as a 
demonstration thing.

			Linus
