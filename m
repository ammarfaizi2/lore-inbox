Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292279AbSBBNbN>; Sat, 2 Feb 2002 08:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292277AbSBBNbD>; Sat, 2 Feb 2002 08:31:03 -0500
Received: from hermes.toad.net ([162.33.130.251]:54762 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S292278AbSBBNax>;
	Sat, 2 Feb 2002 08:30:53 -0500
Subject: Re: apm.c and multiple battery slots
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: Stevie O <stevie@qrpff.net>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 02 Feb 2002 08:30:59 -0500
Message-Id: <1012656665.1379.15.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I went to apm.c to look into patching it to support
> multiple batteries.
> I found this function:
>   static int apm_get_battery_status(which, status, bat,
>                                     life, nbat <- battery #)
> but it's #if 0'd out, and isn't referred to anywhere in the code.
> I looked at the changelog in the file to try to determine when
> it stopped being used, and why, but I found no useful information,
> and I can't even ask the person who did it, since they didn't
> tell me they did...

I am not the author, so the following is speculation.
My guess is that apm_get_battery_status() was written to
support multiple batteries (supported by APM 1.2 only) but
that the authors never got around to providing a user
interface to this functionality; so it remains ifdeffed out.
(Hence the function never "stopped" being used.)

The current official maintainer of the driver is Stephen Rothwell.

Stephen: How do you think the info about the second battery
might be furnished to the user?

--
Thomas







