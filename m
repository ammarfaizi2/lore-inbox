Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267657AbRGPSqn>; Mon, 16 Jul 2001 14:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267654AbRGPSqQ>; Mon, 16 Jul 2001 14:46:16 -0400
Received: from mail.kdt.de ([195.8.224.4]:27146 "EHLO mail.kdt.de")
	by vger.kernel.org with ESMTP id <S267657AbRGPSoz>;
	Mon, 16 Jul 2001 14:44:55 -0400
Mail-Copies-To: never
To: Rolf Fokkens <FokkensR@vertis.nl>
Cc: "'drepper@cygnus.com'" <drepper@cygnus.com>,
        "'alan@lxorguk.ukuu.org.uk'" <alan@lxorguk.ukuu.org.uk>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: /proc/sys/kernel/hz
In-Reply-To: <938F7F15145BD311AECE00508B7152DB034C48DB@vts007.vertis.nl>
From: Andreas Jaeger <aj@suse.de>
Date: Mon, 16 Jul 2001 20:34:23 +0200
In-Reply-To: <938F7F15145BD311AECE00508B7152DB034C48DB@vts007.vertis.nl>
 (Rolf Fokkens's message of "Mon, 16 Jul 2001 20:00:19 +0200")
Message-ID: <u8snfwoh8w.fsf@gromit.moeb>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.4 (Academic Rigor)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Fokkens <FokkensR@vertis.nl> writes:

> Ulrich Drepper <drepper@redhat.com> writes:
> 
>>> Some software (like procps) needs the HZ constant in the kernel. It's
>>> sometimes determined by counting jiffies during a second. The attached
> patch
>>> just "publishes" the HZ constant in /proc/sys/kernel/hz.
>>
>>And what is wrong with
>>  getconf CLK_TCK
>>or programmatically
>>  hz = sysconf (_SC_CLK_TCK);
> 
> In short: it doesn't work: it reads 100 while I changed it to 1024 in my
> kernel.

Then your kernel is broken, check AT_CLKTCK,

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
