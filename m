Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265193AbRGPQzP>; Mon, 16 Jul 2001 12:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265449AbRGPQy4>; Mon, 16 Jul 2001 12:54:56 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:56051 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S265193AbRGPQyr>;
	Mon, 16 Jul 2001 12:54:47 -0400
To: Rolf Fokkens <FokkensR@vertis.nl>
Cc: "'alan@lxorguk.ukuu.org.uk'" <alan@lxorguk.ukuu.org.uk>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: /proc/sys/kernel/hz
In-Reply-To: <938F7F15145BD311AECE00508B7152DB034C48DA@vts007.vertis.nl>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 16 Jul 2001 09:50:35 -0700
In-Reply-To: Rolf Fokkens's message of "Mon, 16 Jul 2001 18:11:14 +0200"
Message-ID: <m38zhorf6s.fsf@otr.mynet>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Fokkens <FokkensR@vertis.nl> writes:

> Some software (like procps) needs the HZ constant in the kernel. It's
> sometimes determined by counting jiffies during a second. The attached patch
> just "publishes" the HZ constant in /proc/sys/kernel/hz.

And what is wrong with

  getconf CLK_TCK

or programmatically

  hz = sysconf (_SC_CLK_TCK);


Update your libc and this info will come from the kernel.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
