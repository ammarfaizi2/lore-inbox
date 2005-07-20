Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVGTPBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVGTPBx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 11:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVGTPBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 11:01:52 -0400
Received: from mx2.elte.hu ([157.181.151.9]:23949 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261345AbVGTPA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 11:00:58 -0400
Date: Wed, 20 Jul 2005 17:00:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Stuart_Hayes@Dell.com
Cc: ak@suse.de, riel@redhat.com, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: page allocation/attributes question (i386/x86_64 specific)
Message-ID: <20050720150029.GA29619@elte.hu>
References: <B1939BC11A23AE47A0DBE89A37CB26B40743C6@ausx3mps305.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B1939BC11A23AE47A0DBE89A37CB26B40743C6@ausx3mps305.aus.amer.dell.com>
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


* Stuart_Hayes@Dell.com <Stuart_Hayes@Dell.com> wrote:

> Ingo Molnar wrote:
> > there's one problem with the patch: it breaks things that need the
> > low 1MB executable (e.g. APM bios32 calls). It would at a minimum be
> > needed to exclude the BIOS area in 0xd0000-0xfffff.  
> > 
> > 	Ingo
> 
> I wrote it to make everything below 1MB executable, if it isn't RAM 
> according to the e820 map, which should include the BIOS area.  This 
> includes 0xd0000-0xffff on my system.  Do you think I should explicity 
> make 0xd0000-0xfffff executable regardless of the e820 map?

hm ... which portion does this? I'm looking at fixnx2.patch. I 
definitely saw a APM bootup crash due to this, but that was on a 2.4-ish 
backport of the patch.

	Ingo
