Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVFBSed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVFBSed (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 14:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVFBSed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 14:34:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:29611 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261229AbVFBSeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 14:34:24 -0400
Date: Thu, 2 Jun 2005 20:33:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: RT patch breaks X86_64 build
Message-ID: <20050602183343.GB30309@elte.hu>
References: <200505302141.31731.kernel-stuff@comcast.net> <200505302201.48123.kernel-stuff@comcast.net> <429BFF51.4000401@stud.feec.vutbr.cz> <200505310753.49447.kernel-stuff@comcast.net> <429C530E.70704@stud.feec.vutbr.cz> <20050601091344.GB11703@elte.hu> <429EFB66.8030909@stud.feec.vutbr.cz> <20050602123927.GB10878@elte.hu> <429F4A19.7030508@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429F4A19.7030508@stud.feec.vutbr.cz>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:

> Ingo Molnar wrote:
> >hm, it does work for me. I had trouble in the past with gcc & mcount on 
> >x64. This version seems to work fine for me:
> >
> > gcc version 3.4.0 20040129 (Red Hat Linux 3.4.0-0.3)
> 
> I could not find this exact version, so I downloaded 
> gcc34-3.4.0-1.x86_64.rpm from Fedora Core 2, converted it do .deb with 
> alien, installed it and made a symlink gcc -> gcc34. gcc --version says:
>   gcc (GCC) 3.4.0 (Red Hat Linux 3.4.0-1)
> 
> I did "make mrproper", copied back your .config, enabled LATENCY_TRACE 
> and rebuilt the kernel.
> init still segfaults.

hm, one difference is that i'm running a 64-bit kernel but 32-bit 
userspace (FC3-ish).

> It would be good to hear about other people's experiences with 
> LATENCY_TRACE on amd64. Am I the only one for whom it breaks?

i definitely had problems with LATENCY_TRACE on x64 in the past - i am 
in fact surprised that it works for me.

	Ingo
