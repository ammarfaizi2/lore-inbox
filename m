Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbUCVJRL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 04:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbUCVJRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 04:17:10 -0500
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:38615 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S261822AbUCVJRG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 04:17:06 -0500
Message-ID: <405EAE8C.2090602@stillhq.com>
Date: Mon, 22 Mar 2004 20:14:52 +1100
From: Michael Still <mikal@stillhq.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Makefile dependancies: scripts depending on configured kernel?
References: <405E1427.6080309@stillhq.com> <20040322055617.GA2250@mars.ravnborg.org>
In-Reply-To: <20040322055617.GA2250@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:

> The dependency for docs is (now) wrong.
> It should be:
> # Documentation targets
> # ---------------------------------------------------------------------------
> %docs: scripts_basic FORCE
>         $(Q)$(MAKE) $(build)=Documentation/DocBook $@
> 
> docproc is the only binary used by Documentation/Docbook, and it is already
> placed in scripts_basic.

True.

> Trivial - so I will include this in some other kbuild patch
> I'm preparing.

Cool, it will be nice to have this working out of the box again.

> Test a bit more, and you will see they are indeed needed.
> Note, some archs other than i386 have a bit different requirements
> because thay do not use an asm-offsett.h file.

Interesting. I built most of the targets and they still worked. I'm 
happy to accept that it's needed though.

Cheers,
Mikal

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 11                          |    -- Homer Simpson
