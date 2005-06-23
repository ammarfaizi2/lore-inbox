Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbVFWMqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbVFWMqu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 08:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbVFWMqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 08:46:50 -0400
Received: from alog0308.analogic.com ([208.224.222.84]:27043 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262398AbVFWMqr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 08:46:47 -0400
Date: Thu, 23 Jun 2005 08:46:30 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Andreas Schwab <schwab@suse.de>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Possible spin-problem in nanosleep()
In-Reply-To: <jell516ymn.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.61.0506230841390.15910@chaos.analogic.com>
References: <Pine.LNX.4.61.0506230812160.15775@chaos.analogic.com>
 <jell516ymn.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1879706418-300157276-1119530790=:15910"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1879706418-300157276-1119530790=:15910
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 23 Jun 2005, Andreas Schwab wrote:

> "Richard B. Johnson" <linux-os@analogic.com> writes:
>
>> nanosleep() appears to have a problem. It may be just an
>> 'accounting' problem, but it isn't pretty. Code that used
>> to use usleep() to spend most of it's time sleeping, used
>> little or no CPU time as shown by `top`. The same code,
>> converted to nanosleep() appears to spend a lot of CPU
>> cycles spinning. The result is that `top` or similar
>> programs show lots of wasted CPU time.
>
> usleep() is just a wrapper around nanosleep().  Are you sure you got the
> units right?
>
> Andreas.
>

Yeah nano is -9 micro is -6, three more zeros when using nano.
I note that the actual syscall is __NR_nanosleep =3D 162. I don't
understand the discrepancy either.

> --=20
> Andreas Schwab, SuSE Labs, schwab@suse.de
> SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
> Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
--1879706418-300157276-1119530790=:15910--
