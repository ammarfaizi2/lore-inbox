Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVA3BRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVA3BRa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 20:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVA3BRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 20:17:30 -0500
Received: from terminus.zytor.com ([209.128.68.124]:29889 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261625AbVA3BRX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 20:17:23 -0500
Message-ID: <41FC3597.8090908@zytor.com>
Date: Sat, 29 Jan 2005 17:17:11 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: kbuild: Implicit dependence on the C compiler
References: <cshbd7$nff$1@terminus.zytor.com> <20050117220052.GB18293@mars.ravnborg.org> <41EC363D.1090106@zytor.com> <20050129212602.GA9610@mars.ravnborg.org>
In-Reply-To: <20050129212602.GA9610@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> 
> make KBUILD_NOCMDDEP=1
> will do what you want - at least I have it in my tree now.
> I could not just ignore 'gcc' - but had to ignore the full commandline.
> 
> This is due to more complex commands like:
> rm -f file; $(LD) ...
> 

That's probably the right behaviour actually.

> Within the Makefile.lib when I check KBUILD_NOCMDDEP there is no
> knowledge of the actual command being executed. And an implmentation
> that just filtered out $(CC) was too ugly.
> And due to the above mentioned command I could not just skip the first
> word on the command line.
> 
> 
> I will push my bk tree soon and it will show up in next -mm.
> 
> It is not perfect in the sense that the last part of the build will get
> redone (GEN .version and onwards). This is fixable but not worth it
> right now.
> 
> So with current implmentation executing:
> 
> make
> 
> make KBUILD_NOCMDDEP=1 CROSS_COMPILE=i586-pc-linux-gnu-
> 
> will result in only a few files being rebuild - and not the whole
> kernel as before.

That's fair.  You got what you asked for.

	-hpa
