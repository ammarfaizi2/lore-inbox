Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbTD3Kz3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 06:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbTD3Kz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 06:55:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20536 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S261570AbTD3Kz2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 06:55:28 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: Andi Kleen <ak@suse.de>, joe briggs <jbriggs@briggsmedia.com>,
       linux-kernel@vger.kernel.org
Subject: Re: software reset
References: <200304291037.13598.jbriggs@briggsmedia.com.suse.lists.linux.kernel>
	<p73vfwx2uw8.fsf@oldwotan.suse.de>
	<20030430075004.GB13859@mail.jlokier.co.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 30 Apr 2003 05:04:59 -0600
In-Reply-To: <20030430075004.GB13859@mail.jlokier.co.uk>
Message-ID: <m1llxsfdpg.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Andi Kleen wrote:
> > The most reliable way is to force a triple fault; load zero into
> > the IDT register and then trigger an exception. The linux kernel 
> > does that in fact for reboot and so far I haven't seen any machine failing
> > to reset yet.
> 
> There are some 486s which don't boot on triple fault, nor on asking
> the keyboard controller to pulse the reset line.  Hence the 3rd option,
> "reboot=bios".

And as an interesting data point all a triple fault does on a modern
system is to put the cpu in a weird stopped state.  Some hardware
usually the southbridge then detects this and if properly configured
will trigger the reset line.

I believe this may actually go back into history as far as the 486 but
I have not done the researched to see how far back this behavior goes.

Eric
