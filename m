Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266459AbUFUUvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266459AbUFUUvA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 16:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266461AbUFUUvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 16:51:00 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:6060 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266459AbUFUUu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 16:50:57 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions
To: "Kirill Korotaev" <kksx@mail.ru>, linux-kernel@vger.kernel.org
Subject: Re: can TSC tick with different speeds on SMP?
Date: Mon, 21 Jun 2004 13:50:09 -0700
User-Agent: KMail/1.5.4
References: <E1BcU4I-000Cj2-00.kksx-mail-ru@f27.mail.ru>
In-Reply-To: <E1BcU4I-000Cj2-00.kksx-mail-ru@f27.mail.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406211350.09295.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IIRC, in the IA64 manuals Intel, by carefully not making any guarantees 
to the contrary, reserved the right to have the TSC-equivalent register 
not be synchronized either to the bus clock or the CPU clock.

This doesn't directly apply to IA32, but may give a hint as to their 
future intentions.


On Monday 21 June 2004 12:02 pm, Kirill Korotaev wrote:
> Hello,
>
> I've got some stupid question to SMP gurus and would be very thankful
> for the details. I suddenly faced an SMP system where different P4
> cpus were installed (with different steppings). This resulted in
> different CPU clock speeds and different speeds of time stamp
> counters on these CPUs. I faced the problem during some timings I
> measured in the kernel.
>
> So the question is "is such system compliant with SMP
> specification?". In old kernels there was a code to syncronize TSCs
> and to detect if they were screwed up. Current kernels do not have
> such code. Is it intentional? I suppose there is some code in kernel
> which won't work find on such systems (real-time threads timing
> accounting and so on).
>
> Thanks in advance,
> Kirill
>
> -
>

-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm

