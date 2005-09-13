Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbVIMTqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbVIMTqu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 15:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbVIMTqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 15:46:49 -0400
Received: from iabervon.org ([66.92.72.58]:20489 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932228AbVIMTqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 15:46:49 -0400
Date: Tue, 13 Sep 2005 15:50:55 -0400 (EDT)
From: Daniel Barkalow <barkalow@iabervon.org>
To: iSteve <isteve@rulez.cz>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: query_modules syscall gone? Any replacement?
In-Reply-To: <4326FDA2.90808@rulez.cz>
Message-ID: <Pine.LNX.4.63.0509131522440.23242@iabervon.org>
References: <4KSFY-2pO-17@gated-at.bofh.it> <E1EDpQq-0000iV-Oe@be1.lrz>
 <4326DE0E.2060306@rulez.cz> <Pine.LNX.4.50.0509130813010.7614-100000@shark.he.net>
 <4326F093.80206@rulez.cz> <Pine.LNX.4.50.0509130835120.7614-100000@shark.he.net>
 <4326FDA2.90808@rulez.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2005, iSteve wrote:

> Part of the project I'm working on -- click-click ui for handling modules,
> with some perks: in this case, getting info about loaded modules that I hoped
> to obtain via query_module.
> 
> Oh, and one more question: There were no particular issues with query_module,
> or were they? If there weren't, why wasn't it kept?

I think it wasn't kept because it would have had to get rewritten anyway, 
and the only user (modutils) was going away. Most of the information was 
only there because the old system needed it, and the new system didn't 
need it, so nobody bothered. Also, the modern style is to avoid 
special-purpose syscalls and use sysfs. It probably wouldn't be too hard 
to get the information exported through the sysfs interface if you ask 
Rusty and explain exactly what you need.

(Note that you can get module symbols by searching /proc/kallsyms for 
<tab>[<name>], so that part is available from the kernel, although not 
efficiently if you have a lot of symbols that you aren't interested in)

	-Daniel
*This .sig left intentionally blank*
