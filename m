Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbRBNRF3>; Wed, 14 Feb 2001 12:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129565AbRBNRFT>; Wed, 14 Feb 2001 12:05:19 -0500
Received: from slc82.modem.xmission.com ([166.70.9.82]:4615 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129457AbRBNRFK>; Wed, 14 Feb 2001 12:05:10 -0500
To: Jeremy Jackson <jeremy.jackson@sympatico.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is this the ultimate stack-smash fix?
In-Reply-To: <3A899FEB.D54ABBC7@sympatico.ca>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Feb 2001 09:25:18 -0700
In-Reply-To: Jeremy Jackson's message of "Tue, 13 Feb 2001 15:58:19 -0500"
Message-ID: <m1lmr98c5t.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Jackson <jeremy.jackson@sympatico.ca> writes:

> Greetings.  This is my first post on linux-kernel, I hope this is
> appropriate.
> 
> The recent CERT IN-2001-01 's massive repercussions and CA-2001-02's
> re-releasing
> old material in an attempt to coerce admins to update their OS, has led
> me to think about
> buffer overrun exploits.   I have gained a new appreciation after being
> rooted twice this month.
> 
> I believe there is a solution that can be implemented in the kernel
> (Linux and probably most Unix)
> that can prevent this type of exploit, has no effect on userspace code,
> and is minimally obtrusive
> for the kernel.

There is another much more effective solution in the works.  The C
standard allows bounds checking of arrays.  So it is quite possible
for the compiler itself to check this in a combination of run-time and
compile-time checks.   I haven't followed up but not too long ago
there was an effort to add this as an option to gcc.  If you really
want this fixed that is the direction to go.  Then buffer overflow
exploits become virtually impossible.

Eric



