Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266130AbRHFJcY>; Mon, 6 Aug 2001 05:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267657AbRHFJcO>; Mon, 6 Aug 2001 05:32:14 -0400
Received: from customers.imt.ru ([212.16.0.33]:17176 "HELO smtp.direct.ru")
	by vger.kernel.org with SMTP id <S266130AbRHFJcC>;
	Mon, 6 Aug 2001 05:32:02 -0400
Message-ID: <20010806022727.A25793@saw.sw.com.sg>
Date: Mon, 6 Aug 2001 02:27:27 -0700
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Colin Walters <walters@cis.ohio-state.edu>, linux-kernel@vger.kernel.org
Subject: Re: eepro100 (PCI ID 82820) lockups/failure
In-Reply-To: <87elqs2wbx.church.of.emacs@space-ghost.verbum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <87elqs2wbx.church.of.emacs@space-ghost.verbum.org>; from "Colin Walters" on Sat, Aug 04, 2001 at 02:06:10AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Aug 04, 2001 at 02:06:10AM -0400, Colin Walters wrote:
> I have an ia32 motherboard (MSI 815EM Pro) with an integrated Intel
> ethernet controller, about which lspci -v has to say:
[snip]
> I'm using the 2.4.7 eepro100 driver, and the machine consistently
> locks up under any kind of heavy network load.  I've tried
> 2.4.8-pre{1,2,3} with the same results.  A message sometimes printed
> to syslog before the machine locks completely is:
> 
> Aug  3 20:56:17 debian kernel: eepro100: wait_for_cmd_done timeout!
> Aug  3 21:01:22 debian kernel: eepro100: wait_for_cmd_done timeout!
> Aug  3 21:01:29 debian kernel: eepro100: wait_for_cmd_done timeout!
> 
> Sometimes it's just the network that goes down, but usually the
> machine will lock not long thereafter.
> 
> I noticed a patch posted to this mailing list:
> 
> <URL:http://mailman.real-time.com/pipermail/linux-kernel/Week-of-Mon-20010618/041187.html>
> 
> But it doesn't seem to have been applied.

Someone who experiences such timeouts needs to figure out how much time it
really can take before a command is accepted.
Some time ago the timeout was increased by the factor of 10, and now the
current timeout looks being insufficient.
It might be a problem with the time of specific commands or specific chip
revisions.
Or some hardware is too clever and somehow optimizes those repeated read
operations, so that they no longer take a fixed number of bus cycles.

In short, that patch isn't a real solution.
If someone provides me with the information which commands times-out and how
much time they really need, we could have a real solution.

Best regards
		Andrey
