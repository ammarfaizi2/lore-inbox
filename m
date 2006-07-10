Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWGJKeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWGJKeE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 06:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWGJKeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 06:34:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:30556 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750903AbWGJKeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 06:34:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Vm5QXK8D5i6sAxME5z/64Y6HzHUNCifNmsqfsMYtTuFaY98HwOPlRx/Ku5qL55w59FFNJM1U+vNFC+/3+VxriFbxWfuaULOySvsUsyTBv6SgDEoraabWKxKfLmw/H0DIxRe9k9hKY8EtPI0cLbgQgDsWp6O2iniiwXz0SGk7SzQ=
Message-ID: <84144f020607100333s57159d38ha1101c65e8c099b1@mail.gmail.com>
Date: Mon, 10 Jul 2006 13:33:59 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Mike Galbraith" <efault@gmx.de>
Subject: Re: 2.6.18-rc1: slab BUG_ON(!PageSlab(page)) upon umount after failed suspend
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1152527148.8700.8.camel@Homer.TheSimpsons.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6wDCq-5xj-25@gated-at.bofh.it> <6wM2X-1lt-7@gated-at.bofh.it>
	 <6wOxP-4QN-5@gated-at.bofh.it> <44B189D3.4090303@imap.cc>
	 <20060709161712.c6d2aecb.akpm@osdl.org>
	 <1152513068.7748.13.camel@Homer.TheSimpsons.net>
	 <84144f020607100142l62f02321i9802f9eed64d39f4@mail.gmail.com>
	 <1152527148.8700.8.camel@Homer.TheSimpsons.net>
X-Google-Sender-Auth: 22b32904c328afba
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Mike Galbraith <efault@gmx.de> wrote:
> Hm.  I've never _noticed_ gcc putting anything out there before.  This
> is gcc version 4.1.2 20060531 (prerelease) (SUSE Linux).

[snip]

Curious... GCC cuts line and file information after ud2a. Looking at
your stack trace, I am wondering who calls free_block() as we don't
see cache_flusharray() in the trace. Do you have CONFIG_NUMA enabled?

                                                    Pekka
