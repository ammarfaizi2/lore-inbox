Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVDSQDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVDSQDB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 12:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVDSQDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 12:03:01 -0400
Received: from web88105.mail.re2.yahoo.com ([206.190.37.206]:58762 "HELO
	web88105.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261615AbVDSQC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 12:02:58 -0400
Message-ID: <20050419160254.60823.qmail@web88105.mail.re2.yahoo.com>
Date: Tue, 19 Apr 2005 12:02:54 -0400 (EDT)
From: Anthony Russello <arussello@rogers.com>
Subject: Re: hang in rest_init, kernel_thread call 2.6.12-rc2
To: Anthony Russello <arussello@rogers.com>, linux-kernel@vger.kernel.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for the preemptive email.  I found the issue,
and it was actually a little bit later than the kernel
thread call.

Thanks,
Anthony
--- Anthony Russello <arussello@rogers.com> wrote:
> Hi All,
> 
> I'm currently trying to bring 2.6.12-rc2 up on a
> board
> using the Freescale 8240 CPU.  I'm also using, for
> the
> most part, the sandpoint platform specific code.
> 
> Currently I am experiencing a hang in the function
> rest_init within init/main.c when the kernel
> attempts
> to kick off its init thread:
> 
> kernel_thread(init, NULL, CLONE_FS | CLONE_SIGHAND);
> 
> Has anyone seen this behaviour before?
> 
> Currently, in order to debug this I've been writing
> a
> single character out to the address where the serial
> port lies.  That is how I've been able to determine
> exactly where I'm stuck.
> 
> Has anyone else come across this?  If so, how were
> you
> able to debug it?  I'd appreciate any tips or tricks
> you might be able to give.
> 
> Thank you in advance for any help you might be able
> to
> offer.
> 
> Cheers,
> Anthony
> 
