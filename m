Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWCRI6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWCRI6x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 03:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWCRI6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 03:58:52 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:40661 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932331AbWCRI6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 03:58:51 -0500
Date: Sat, 18 Mar 2006 09:56:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Jan Altenberg <tb10alj@tglx.de>,
       Sastien Dugu <sebastien.dugue@bull.net>
Subject: Re: 2.6.16-rc6-rt3
Message-ID: <20060318085631.GC23317@elte.hu>
References: <20060314084658.GA28947@elte.hu> <4416C6DD.80209@cybsft.com> <20060314142458.GA21796@elte.hu> <4416F14E.1040708@cybsft.com> <20060317092351.GA18491@elte.hu> <441AE417.1030601@cybsft.com> <20060317203149.GA23069@elte.hu> <441B756A.9060309@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441B756A.9060309@cybsft.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> Ingo Molnar wrote:
> > * K.R. Foley <kr@cybsft.com> wrote:
> > 
> >> OK. Tried rt9 with a clean build and still no joy. I've attached the 
> >> log which looks like it could be a similar problem?
> > 
> > seems to be a different one:
> > 
> >> input: ImPS/2 Generic Wheel Mouse as /class/input/input1
> >> Freeing unused kernel memory: 284k freed
> >> Could not allocate 8 bytes percpu data
> >> sd_mod: Unknown symbol scsi_print_sense_hdr
> > 
> > could you increase PERCPU_ENOUGH_ROOM in include/linux/percpu.h? (to 
> > e.g. 65536)
> > 
> > 	Ingo
> > 
> 
> Perhaps I misunderstood what you wanted me to do before. Just for 
> grins I doubled the PERCPU_ENOUGH_ROOM to 131072 and have successfully 
> booted twice now.

great. (i quoted the wrong number above, the -rt tree already doubled 
the value, so we needed yet another doubling)

	Ingo
