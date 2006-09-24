Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752063AbWIXSH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbWIXSH6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 14:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbWIXSH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 14:07:57 -0400
Received: from mail.aknet.ru ([82.179.72.26]:28177 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1752120AbWIXSHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 14:07:54 -0400
Message-ID: <4516C9D0.3080606@aknet.ru>
Date: Sun, 24 Sep 2006 22:09:20 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru>	 <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>	 <451555CB.5010006@aknet.ru>	 <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>	 <1159037913.24572.62.camel@localhost.localdomain>	 <45162BE5.2020100@aknet.ru> <1159106032.11049.12.camel@localhost.localdomain> <45169C0C.5010001@aknet.ru> <4516A8E3.4020100@redhat.com> <4516B2C8.4050202@aknet.ru> <4516B721.5070801@redhat.com>
In-Reply-To: <4516B721.5070801@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> The consensus has been to add the same checks to mprotect.  They were
> not left out intentionally.
But how about the anonymous mmap with PROT_EXEC set?
This is exactly what the malicious loader will do, it
won't do the shared (or private) file-backed mmap.
So your technique doesn't restrict the malicious
loaders, including the potential script loader you
were referring to. It doesn't even make their life
any harder. Only the properly-written programs suffer.
Or, in case of ceasing to use noexec - the security.

