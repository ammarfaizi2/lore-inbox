Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966097AbWKODtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966097AbWKODtm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 22:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966103AbWKODtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 22:49:42 -0500
Received: from cantor2.suse.de ([195.135.220.15]:60065 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S966097AbWKODtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 22:49:41 -0500
From: Andi Kleen <ak@suse.de>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] [PATCH 10/16] x86_64: 64bit PIC ACPI wakeup
Date: Wed, 15 Nov 2006 04:49:25 +0100
User-Agent: KMail/1.9.5
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Vivek Goyal <vgoyal@in.ibm.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, akpm@osdl.org,
       hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com
References: <20061113162135.GA17429@in.ibm.com> <m1fyclk8ws.fsf@ebiederm.dsl.xmission.com> <20061114234334.GB3394@elf.ucw.cz>
In-Reply-To: <20061114234334.GB3394@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611150449.26057.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 00:43, Pavel Machek wrote:
> Hi!
> 
> > >> I don't have a configuration I can test this but it compiles cleanly
> > >
> > > Ugh, now that's a big patch.. and untested, too :-(.
> > 
> > It was very carefully code reviewed at least the first time,
> > and the code was put in sync with code that was tested.
> 
> So we had two very different versions of "switch to 64-bit" and now we
> have two mostly similar versions. Not a big improvement...

Hmm? That's an improvement in my book. Of course i would prefer
truly shared code, but even more similar code is better.

> > > Why is PGE no longer required, for example?
> > 
> > PGE is never required.  Especially on a temporary page table.
> > PGE is an optimization, to make context switches faster.
> 
> HPA tells me it is.

He was just nitpicking. Eric is right it is just an optimization
(modulo hardware/software bugs) 

-Andi
