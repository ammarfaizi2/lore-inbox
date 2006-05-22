Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWEVFYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWEVFYt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 01:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbWEVFYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 01:24:48 -0400
Received: from bsamwel.xs4all.nl ([82.92.179.183]:19703 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S1750917AbWEVFYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 01:24:48 -0400
Message-ID: <44714AC1.1060004@samwel.tk>
Date: Mon, 22 May 2006 07:23:13 +0200
From: Bart Samwel <bart@samwel.tk>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH 10/14/] Doc. sources: expose laptop-mode
References: <20060521203349.40b40930.rdunlap@xenotime.net> <20060521205750.003b737c.rdunlap@xenotime.net>
In-Reply-To: <20060521205750.003b737c.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Documentation/laptop-mode.txt:
> Expose example and tool source files in the Documentation/ directory in
> their own files instead of being buried (almost hidden) in readme/txt files.
> 
> This will make them more visible/usable to users who may need
> to use them, to developers who may need to test with them, and
> to janitors who would update them if they were more visible.
> 
> Also, if any of these possibly should not be in the kernel tree at
> all, it will be clearer that they are here and we can discuss if
> they should be removed.
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> ---
>  Documentation/dslm.c          |  166 +++++++++++++++++++++++++++++++++++++++++
>  Documentation/laptop-mode.txt |  170 ------------------------------------------

Arguably, dslm.c should be removed completely. It's something for which 
everyone who knows how to compile a file named "dslm.c" can write a 
usable replacement, using a couple of lines of shell scripting. If we 
should include anything, it should be those lines of shell scripting, in 
the docs, at most.

Point for discussion: should the laptop_mode script really still be in 
laptop-mode.txt? AFAIK most distros use laptop-mode-tools or use their 
own scripts to control this. Furthermore, the existing script is mostly 
unmaintained, and it is full of bugs that were fixed long ago in 
laptop-mode-tools (which was originally a fork of the script). I think 
it would be better to replace it with a bit of documentation on which 
things a laptop mode control script *should* tweak, *may want to* tweak, 
etc., accompanied by an explanation why these tweaks are needed. I.e, an 
"annotated spec", as one would expect to find in documentation. I'll 
submit a patch to this effect when I find some time.

Cheers,
Bart
