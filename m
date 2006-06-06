Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWFFNeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWFFNeU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 09:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWFFNeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 09:34:20 -0400
Received: from mx1.suse.de ([195.135.220.2]:21195 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932162AbWFFNeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 09:34:19 -0400
From: Andi Kleen <ak@suse.de>
To: Martin Bisson <bissonm@discreet.com>
Subject: Re: x86_64 system call entry points II
Date: Tue, 6 Jun 2006 15:34:12 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <44846210.4080602@discreet.com> <p73verezw9t.fsf@verdi.suse.de> <4485825D.9000606@discreet.com>
In-Reply-To: <4485825D.9000606@discreet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606061534.12228.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I think the bottom line for me is simply that I cannot enter system 
> calls any way I want with any kernel,

Only for SYSENTER. int 0x80 and SYSCALL don't have this problem.

For SYSENTER you can just call the trampoline in the vsyscall page.
glibc does that too. The address can be found in the ELF aux vector.

-Andi

