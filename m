Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbUHWQC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUHWQC5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 12:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbUHWP7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:59:06 -0400
Received: from the-village.bc.nu ([81.2.110.252]:28817 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265808AbUHWPzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:55:40 -0400
Subject: Re: Problems compiling kernel modules
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lei Yang <leiyang@nec-labs.com>
Cc: root@chaos.analogic.com, Lee Revell <rlrevell@joe-job.com>,
       Sam Ravnborg <sam@ravnborg.org>,
       Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <412A01AC.5020108@nec-labs.com>
References: <4127A15C.1010905@nec-labs.com>
	 <20040821214402.GA7266@mars.ravnborg.org> <4127A662.2090708@nec-labs.com>
	 <20040821215055.GB7266@mars.ravnborg.org>  <4127B49A.6080305@nec-labs.com>
	 <1093121824.854.167.camel@krustophenia.net> <4129FAC8.3040502@nec-labs.com>
	 <Pine.LNX.4.53.0408231018001.7732@chaos>  <412A01AC.5020108@nec-labs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093272770.29758.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 23 Aug 2004 15:52:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-23 at 15:39, Lei Yang wrote:
> Thanks! I did less /var/log/messages, and got the unknown symbols
> Unknown symbol __divsf3
> Unknown symbol __fixsfsi
> Unknown symbol __subsf3
> Unknown symbol __floatsisf
> Unknown symbol __mulsf3
> Unknown symbol __gesf2
> Unknown symbol __addsf3
> 
> However, I don't know what those symbols are :( I am a bit worried that 
> maybe I've done something that is not supported by the kernel, like 
> left-shift 16 bits of an int, or floating operations.

You are correct - the kernel doesn't support floating point operations
used in kernel space unless you do some fairly tricky stuff.

