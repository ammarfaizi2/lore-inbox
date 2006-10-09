Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWJIEiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWJIEiA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 00:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWJIEiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 00:38:00 -0400
Received: from mail.aknet.ru ([82.179.72.26]:20746 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S932234AbWJIEh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 00:37:59 -0400
Message-ID: <4529D2AD.9080509@aknet.ru>
Date: Mon, 09 Oct 2006 08:40:13 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jakub Jelinek <jakub@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch] honour MNT_NOEXEC for access()
References: <200610090209.k9929IdP009924@laptop13.inf.utfsm.cl>
In-Reply-To: <200610090209.k9929IdP009924@laptop13.inf.utfsm.cl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Horst H. von Brand wrote:
> Right. But what prevents anybody to have a hacked, non-testing, ld.so lying
> around?
Having "noexec" on every user-writable mount can
kind of make that difficult - you can't easily run
the ld.so you just copied in.

> It just can't do them (reliably at least) in general.
Certainly it can't, now and then.
Right now the check is to see whether the mmap(PROT_EXEC)
fails. I wanted to change that to something that at least
won't break other apps, but of course without adding any
extra reliability.

