Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266821AbUJRQXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266821AbUJRQXp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 12:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUJRQXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 12:23:45 -0400
Received: from zero.aec.at ([193.170.194.10]:55824 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266821AbUJRQXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 12:23:44 -0400
To: Paul Mackerras <paulus@samba.org>
cc: linux-kernel@vger.kernel.org, olh@suse.de
Subject: Re: [PATCH] allow kernel compile with native ppc64 compiler
References: <2Qoqo-Ou-41@gated-at.bofh.it> <2Qr4K-2P8-15@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 18 Oct 2004 18:23:27 +0200
In-Reply-To: <2Qr4K-2P8-15@gated-at.bofh.it> (Paul Mackerras's message of
 "Sun, 17 Oct 2004 23:50:10 +0200")
Message-ID: <m3k6toc7wg.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> writes:

> Olaf Hering writes:
>
>> The zImage is a 32bit binary, but a native powerpc64-linux gcc will
>> produce 64bit objects in arch/ppc64/boot.
>> This patch fixes it.
>
> ... and breaks the compile on older toolchains that don't understand
> -m32.  We need to make the -m32 conditional on HAS_BIARCH as defined
> in arch/ppc64/Makefile.

Wouldn't it be more user friendly to use $(call check_gcc,-m32,) ? 

-Andi

