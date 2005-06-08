Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbVFHWlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbVFHWlK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 18:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVFHWlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 18:41:10 -0400
Received: from mail.suse.de ([195.135.220.2]:57753 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262213AbVFHWk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 18:40:56 -0400
From: Andreas Schwab <schwab@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, akpm@osdl.org, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc64: Fix PER_LINUX32 behaviour
References: <17062.56723.535978.961340@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0506081022030.2286@ppc970.osdl.org>
	<jey89kbmsc.fsf@sykes.suse.de> <87u0k8k1s6.fsf@blackdown.de>
X-Yow: My EARS are GONE!!
Date: Thu, 09 Jun 2005 00:40:51 +0200
In-Reply-To: <87u0k8k1s6.fsf@blackdown.de> (Juergen Kreileder's message of
	"Wed, 08 Jun 2005 22:54:17 +0200")
Message-ID: <jed5qwbhfw.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Kreileder <jk@blackdown.de> writes:

> The current code doesn't work like intended, on my G5 both 'linux32
> uname -m' and 'linux32 sh -c "uname -m"' return 'ppc64' without the
> patch.

You appear to be using some very old version of glibc.  I can't reproduce
that here.  Are you sure you aren't using syscall 109 (__NR_olduname)
instead of 122 (__NR_uname)?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
