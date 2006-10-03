Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030448AbWJCSES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030448AbWJCSES (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 14:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbWJCSES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 14:04:18 -0400
Received: from mail.aknet.ru ([82.179.72.26]:14859 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1030449AbWJCSER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 14:04:17 -0400
Message-ID: <4522A691.7070700@aknet.ru>
Date: Tue, 03 Oct 2006 22:06:09 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Valdis.Kletnieks@vt.edu
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru>	 <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>	 <451555CB.5010006@aknet.ru>	 <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>	 <1159037913.24572.62.camel@localhost.localdomain>	 <45162BE5.2020100@aknet.ru>	 <1159106032.11049.12.camel@localhost.localdomain>	 <45169C0C.5010001@aknet.ru> <4516A8E3.4020100@redhat.com>	 <4516B2C8.4050202@aknet.ru> <4516B721.5070801@redhat.com>	 <45198395.4050008@aknet.ru>	 <1159396436.3086.51.camel@laptopd505.fenrus.org>  <451E3C0C.10105@aknet.ru> <1159887682.2891.537.camel@laptopd505.fenrus.org> <45229A99.6060703@aknet.ru> <45229C8E.6080503@redhat.com>
In-Reply-To: <45229C8E.6080503@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Ulrich Drepper wrote:
> You keep repeating the same nonsense over and over again, lot listening
> to anybody who doesn't agree with your position.
My position is simple: the ld.so problem needs a better
solution than the current one. The current one, for example,
still allows to use ld.so directly to execute the files for
which you do not have an exec permission. And that's not an
only problem...

> If you don't want to have the noexec semantics on a filesystem, remove
> it.
And allow an attacker to store his files on that partition,
and then execute them.

> Not using the strict (mmap + protect) makes the whole thing
There is no "mmap + mprotect" here - only mmap was changed.

> completely meaningless since ld.so can be invoked directly.
I have already proposed another solution for ld.so problem
3 times. That fact doesn't make it a good solution of course,
but obviously you haven't had a look.

