Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264582AbUFUTWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbUFUTWf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 15:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266421AbUFUTWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 15:22:35 -0400
Received: from main.gmane.org ([80.91.224.249]:23715 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264582AbUFUTWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 15:22:33 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: can TSC tick with different speeds on SMP?
Date: Mon, 21 Jun 2004 19:22:30 +0000 (UTC)
Message-ID: <slrncdedbm.a4u.psavo@varg.dyndns.org>
References: <E1BcU4I-000Cj2-00.kksx-mail-ru@f27.mail.ru>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a11a.mannikko1.ton.tut.fi
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kirill Korotaev <kksx@mail.ru>:
> Hello,
>
> I've got some stupid question to SMP gurus and would be very thankful
> for the details. I suddenly faced an SMP system where different P4 cpus
> were installed (with different steppings). This resulted in different
> CPU clock speeds and different speeds of time stamp counters on these
> CPUs. I faced the problem during some timings I measured in the kernel.
>   
> So the question is "is such system compliant with SMP specification?".

Well, I can't tell if it's SMP-compliant, but I can tell that it's
certainly not rare to have such a situation.

For example on AMD K7-SMP system when using powersaving mode which
basically 'turns CPU off' for a while, TSC's become desynchronized. At
the moment 2.6 -kernels handle this very well. (I haven't got problems
with it for more than half a year).

Now, I don't know what will happen if the become desynchronized because
of totally different _length_ of single tick. Is this what you
experience?

FWIW, this is what I get for timer in dmesg:
- -
 ...
Using pmtmr for high-res timesource
 ...
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1545.0689 MHz.
..... host bus clock speed is 268.0815 MHz.
checking TSC synchronization across 2 CPUs: passed.
 ...
- -


-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

