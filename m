Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVCCAfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVCCAfz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 19:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVCCAcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 19:32:12 -0500
Received: from fire.osdl.org ([65.172.181.4]:5505 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261271AbVCCAaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 19:30:15 -0500
Date: Wed, 2 Mar 2005 16:30:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1: something is wrong with swsusp powerdown
Message-Id: <20050302163008.322031d3.akpm@osdl.org>
In-Reply-To: <d05g45$pos$1@sea.gmane.org>
References: <20050228231721.GA1326@elf.ucw.cz>
	<d05g45$pos$1@sea.gmane.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Please do reply-to-all)

Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz> wrote:
>
> Pavel Machek wrote:
> > Hi!
> > 
> > In `subj` kernel, machine no longer powers down at the end of
> > swsusp. 2.6.11-rc5-pavel works ok, as does 2.6.11-bk.
> 
> For me, power down stopped working since the introduction of softlockup 
> detection. After disabling CONFIG_DETECT_SOFTLOCKUP, powerdown works fine.

Could you send the output which CONFIG_DETECT_SOFTLOCKUP generates?

I had one CONFIG_DETECT_SOFTLOCKUP failure with suspend, on SMP.  The
machine was stuck somewhere under mce_work_fn().  Perhaps in the
smp_call_function().  It only happened the once.
