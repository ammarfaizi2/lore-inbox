Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264788AbTBAKqr>; Sat, 1 Feb 2003 05:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264790AbTBAKqr>; Sat, 1 Feb 2003 05:46:47 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:41870 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S264788AbTBAKqr>; Sat, 1 Feb 2003 05:46:47 -0500
Message-Id: <200302011055.LAA29753@post.webmailer.de>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: [PATCH] Module alias and device table support. 
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Date: Sat, 01 Feb 2003 11:36:34 +0100
References: <20030201073007$5418@gated-at.bofh.it> <20030201073007$3e7f@gated-at.bofh.it>
Organization: IBM Deutschland Entwicklung GmbH
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:

> Alright. I think we're heading towards a generic postprocessor here, which
> takes the .o, extracts information as necessary and generates some .c file 
> which contains e.g. checksums for the unresolved symbols (when MODVERSIONS 
> is selected), a section to record which modules we depend on, an alias 
> section etc. This .c is then compiled and linked into the final .ko
...
> Yup, I think modversions should have a little time to settle first. 
> There's really only one tricky point with modversions (and the other stuff 
> above), i.e. we need a complete list of all modules. With people 
> playing tricks with "make SUBDIRS=..." that needs some care to not go 
> accidentally wrong.

Worse that "make SUBDIRS=...", what do you think can be done about third
party modules? After all, I thought they are what modversions are about.
I don't see how you can reliably find the list of required modules when
you build a module outside of the kernel tree.

        Arnd <><
