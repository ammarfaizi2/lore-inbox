Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWIXOwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWIXOwk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 10:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWIXOwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 10:52:39 -0400
Received: from mail.aknet.ru ([82.179.72.26]:28433 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751123AbWIXOwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 10:52:39 -0400
Message-ID: <45169C0C.5010001@aknet.ru>
Date: Sun, 24 Sep 2006 18:54:04 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru>	 <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>	 <451555CB.5010006@aknet.ru>	 <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>	 <1159037913.24572.62.camel@localhost.localdomain>	 <45162BE5.2020100@aknet.ru> <1159106032.11049.12.camel@localhost.localdomain>
In-Reply-To: <1159106032.11049.12.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:
> If you want a tmpfs with noexec and a shared memory space with exec why
> don't you just sort out mounting two different tmpfs instances ?
The one that goes to /dev/shm should allow PROT_EXEC, yet
not allow executing the binaries with execve(). How?
There may be other tmpfs instances, I think they are
unaffected, but what to do with the /dev/shm one?

