Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271281AbTHCVKo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 17:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271284AbTHCVIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 17:08:31 -0400
Received: from codepoet.org ([166.70.99.138]:40170 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S271281AbTHCVIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 17:08:23 -0400
Date: Sun, 3 Aug 2003 15:08:22 -0600
From: Erik Andersen <andersen@codepoet.org>
To: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       devik@cdi.cz
Subject: Re: [PATCH] Allow /dev/{,k}mem to be disabled to prevent kernel from being modified easily
Message-ID: <20030803210821.GA17710@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, devik@cdi.cz
References: <20030803180950.GA11575@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030803180950.GA11575@outpost.ds9a.nl>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Aug 03, 2003 at 08:09:50PM +0200, bert hubert wrote:
> Greetings,
> 
> After being gloriously rootkitted with a program coded by HTB author Martin
> Devera (lots of thanks, devik, your work is appreciated, I suggest you read
> up about Oppenheimer when disclaiming that you are 'just a coder'. The item
> to google on is: "ethics sweetness hydrogen bomb Oppenheimer"), I wrote
> a patch to disable /dev/kmem and /dev/mem, which is harmless on servers
> without X.
> 
> It blocks attempts by rootkits, such as devik's SucKIT, to hide themselves.

Until the rootkit, already running as root, loads stuff as a
kernel module...  Perhaps you should make this enforce that
people have CONFIG_MODULES=n,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
