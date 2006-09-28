Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWI1Ecc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWI1Ecc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 00:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWI1Ecc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 00:32:32 -0400
Received: from mail.aknet.ru ([82.179.72.26]:44043 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751367AbWI1Ecb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 00:32:31 -0400
Message-ID: <451B5096.6020205@aknet.ru>
Date: Thu, 28 Sep 2006 08:33:26 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ulrich Drepper <drepper@redhat.com>,
       Valdis.Kletnieks@vt.edu, Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC MAP_PRIVATE mmaps
References: <45150CD7.4010708@aknet.ru>  <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>  <451555CB.5010006@aknet.ru>  <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>  <1159037913.24572.62.camel@localhost.localdomain>  <45162BE5.2020100@aknet.ru> <1159106032.11049.12.camel@localhost.localdomain> <45169C0C.5010001@aknet.ru> <4516A8E3.4020100@redhat.com> <4516B2C8.4050202@aknet.ru> <4516B721.5070801@redhat.com> <451ACE29.4080005@aknet.ru> <Pine.LNX.4.64.0609272045560.24191@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0609272045560.24191@blonde.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Hugh Dickins wrote:
> since executables are typically mapped MAP_PRIVATE, I suspect
> your patch will simply break mmap's intended MNT_NOEXEC check.
The one with ld.so you mean? But its a user-space issue,
I haven't seen anyone claiming the opposite (and you even
explicitly confirmed it is).

> I think you need to face up to the fact that "noexec"
> doesn't suit your mount, and just leave it at that.
But noone have answered this question:
Which configuration is more secure - the one where all
the user-writable fs are mounted with "noexec" (in old
sense of noexec), or the one without "noexec" at all
because I should no longer use it here and there (actually,
everywhere)?

> But I do concede that I'm reluctant to present that patch Alan
> encouraged, adding a matching MNT_NOEXEC check to mprotect: it
> would be consistent, and I do like consistency, but in this case
> fear that change in behaviour may cause new userspace breakage.
I can't think of a single real-life example where it will
break something over whatever is broken already by the mmap
check. But I am not encouraging such a change of course.

